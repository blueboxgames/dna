package model
{
    import view.FieldView;
    import view.PlayerView;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import utils.CoreUtils;

    public class Player extends EventDispatcher
    {
        public static const START_HEALTH:int = 3;
        public function Player(id:int)
        {
            this.v = new PlayerView(id);
            this.id = id;
        }

        

        private var id:int = 0;

        private var _x:int = 0;
        
        public function get x():int
        {
            return _x;
        }
        
        public function set x(value:int):void
        {
            _x = value;
            this.v.x = _x;
        }

        private var _y:int = 0;
        
        public function get y():int
        {
            return _y;
        }
        
        public function set y(value:int):void
        {
            _y = value;
            this.v.y = _y;
        }

        private var _health:int = START_HEALTH;
        
        public function get health():int
        {
            return _health;
        }
        
        public function set health(value:int):void
        {
            _health = value;
            this.fieldView.healthGroup.decrease();
            if( this.health <= 0 )
            {
                this.fieldView.healthGroup.reset();
                this.die();
            }
            if( this.health < 0 )
            {
                this.fieldView.healthGroup.reset();
                this.endDie()
            }
        }

        public var radiusX:int = 10;
        public var radiusY:int = 10;
        public var maxPickRadius:Number = 20;
        public var maxHitRadius:Number = 50;
        public var v:PlayerView;
        public var fieldView:FieldView;
        
        public var damage:int = 1;
        private var _disable:Boolean;
        
        public function get disable():Boolean
        {
            return _disable;
        }
        
        public function set disable(value:Boolean):void
        {
            /* this.currentCommand = 0; */
            _disable = value;
        }

        public var speedFactor:int = 4;
        public var currentItem:Tool = null;
        public var actionDisable:Boolean = false;
        public var currentState:String = Character.STATE_NAME_IDLE;

        private var _currentCommand:int;
        
        public function get currentCommand():int
        {
            return _currentCommand;
        }
        
        public function set currentCommand(value:int):void
        {
            _currentCommand = value;
            if( (this.v.scaleX > 0 && _currentCommand & Command.COMMAND_RIGHT) || (this.v.scaleX < 0 && _currentCommand & Command.COMMAND_LEFT) )
                this.v.scaleX = -this.v.scaleX;
            
            if( currentState == Character.STATE_NAME_CARRY )
            {
                if( (_currentCommand & 0x000f) == 0x0 )
                    this.currentAnimation  = Character.STATE_NAME_IDLE_CARRY;
                else
                    this.currentAnimation = Character.STATE_NAME_CARRY;
                return;
            }
            
            if( currentAnimation == Character.STATE_NAME_PUNCH )
                return;

            if( ( _currentCommand == 0 ) && currentState != Character.STATE_NAME_IDLE )
            {
                this.currentAnimation = Character.STATE_NAME_IDLE;
                currentState = Character.STATE_NAME_IDLE;
            }

            if( (_currentCommand & 0x000f) != 0x0 && currentState != Character.STATE_NAME_WALK  )
            {
                this.currentAnimation = Character.STATE_NAME_WALK;
                currentState = Character.STATE_NAME_WALK;
            }

            if( currentState == Character.STATE_NAME_WALK )
                this._currentAnimation = Character.STATE_NAME_WALK;
            if( currentState == Character.STATE_NAME_IDLE )
                this.currentAnimation = Character.STATE_NAME_IDLE;

        }

        private var _score:int;
        
        public function get score():int
        {
            return _score;
        }
        
        public function set score(value:int):void
        {
            _score = value;
            trace("SCORE = " + value);
            this.dispatchEvent(new Event(Event.CHANGE));
        }
        /**
         * sets a command flag.
         */
        public function execute(action:int):int {
            var status:int = 0;
            if( this.disable )
                return -1;
            if( (this.currentCommand & action) != action )
                this.currentCommand |= action;
            return status;
        }

        /**
         * unset a command flag.
         */
        public function unexecute(action:int):int {
            var status:int = 0;
            this.currentCommand &= ~action;
            return status;
        }

        public function hit(player:Player):void {
            if( this.disable )
                return;
            this.currentAnimation = Character.STATE_NAME_PUNCH;
            this.disable = true;
        }

        public function hitAttackReEnable(e:Event):void {
            this.v.character.removeEventListener(Character.EVENT_END_HIT, hitAttackReEnable);
            this.disable = false;
            if( this.currentState == Character.STATE_NAME_WALK && (this.currentCommand & 0xf) != 0 )
                this.currentAnimation = Character.STATE_NAME_WALK;
            else
                this.currentAnimation = Character.STATE_NAME_IDLE;
            if( this.id == 0 )
            {
                if( CoreUtils.getDistance(this.x, this.fieldView.player2.x, this.y, this.fieldView.player2.y) < this.maxHitRadius)
                {
                    this.fieldView.player1.addEventListener(Character.EVENT_END_HIT, endHit1_eventHandler);
                    this.fieldView.player2.currentAnimation = Character.STATE_NAME_GET_HIT;
                    this.fieldView.player2.health -= this.damage;
                }
                return;
            }
            else
            {
                if( CoreUtils.getDistance(this.x, this.fieldView.player1.x, this.y, this.fieldView.player1.y) < this.maxHitRadius)
                {
                    this.fieldView.player2.addEventListener(Character.EVENT_END_HIT, endHit2_eventHandler);
                    this.fieldView.player1.currentAnimation = Character.STATE_NAME_GET_HIT;
                    this.fieldView.player1.health -= this.damage;
                }
                return;
            }
        }

        private function endHit1_eventHandler(event:Event):void
        {
            this.fieldView.player1.removeEventListener(Character.EVENT_END_HIT, endHit1_eventHandler);
            trace(this.fieldView.player2.currentState);
            if(this.fieldView.player2.health > 0 )
                this.fieldView.player2.currentAnimation(this.fieldView.player2.currentState);
        }

        private function endHit2_eventHandler(event:Event):void
        {
            this.fieldView.player2.removeEventListener(Character.EVENT_END_HIT, endHit2_eventHandler);
            trace(this.fieldView.player1.currentState)
            if(this.fieldView.player1.health > 0 )
                this.fieldView.player1.currentAnimation(this.fieldView.player2.currentState);
        }

        private function die():void {
            this.disable = true;
            this.v.character.addEventListener(Character.EVENT_END_DIE, endDie);
            this.currentAnimation = Character.STATE_NAME_DIE;
        }

        private function endDie(e:Event=null):void {
            this.health = START_HEALTH;
            this.currentCommand = 0;
            this.currentState = Character.STATE_NAME_IDLE;
            this.disable = false;
            this.currentAnimation = Character.STATE_NAME_IDLE;
            if( this.id == 0 )
            {
                this.x = FieldView.PLAYER1_START_X;
                this.y = FieldView.PLAYER1_START_Y;
            }
            else
            {
                this.x = FieldView.PLAYER2_START_X;
                this.y = FieldView.PLAYER2_START_Y;
            }
        }

        private var _currentAnimation:String;
        
        public function get currentAnimation():String
        {
            return _currentAnimation;
        }
        
        public function set currentAnimation(value:String):void
        {
            if(this.currentAnimation == value)
                return;
            _currentAnimation = value;
            this.v.character.gotoAndPlay(_currentAnimation);
        }
    }
}