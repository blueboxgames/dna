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
            if( this.health <= 0 )
                this.die();
        }

        public var radiusX:int = 10;
        public var radiusY:int = 10;
        public var maxPickRadius:Number = 20;
        public var maxHitRadius:Number = 20;
        public var v:PlayerView;
        public var fieldView:FieldView;
        
        public var damage:int = 1;
        public var disable:Boolean = false;

        public var speedFactor:int = 2;
        public var currentItem:Tool = null;
        public var actionDisable:Boolean = false;
        public var currentState:String = Character.STATE_NAME_IDLE;

        private var _currentCommand:int;
        
        public function get currentCommand():int
        {
            trace(_currentCommand);
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
                    this.v.character.gotoAndPlay(Character.STATE_NAME_IDLE_CARRY);
                else
                    this.v.character.gotoAndPlay(Character.STATE_NAME_CARRY);
                return;
            }
            if( currentState == Character.STATE_NAME_PUNCH )
                return;

            if( ( _currentCommand == 0 ) && currentState != Character.STATE_NAME_IDLE )
            {
                this.v.character.gotoAndPlay(Character.STATE_NAME_IDLE);
                currentState = Character.STATE_NAME_IDLE;
            }
            if( (_currentCommand & 0x000f) != 0x0 && currentState != Character.STATE_NAME_WALK )
            {
                this.v.character.gotoAndPlay(Character.STATE_NAME_WALK);
                currentState = Character.STATE_NAME_WALK;
            }
        }

        private var _score:int;
        
        public function get score():int
        {
            return _score;
        }
        
        public function set score(value:int):void
        {
            _score = value;
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
            if( this.disable )
                return -1;
            this.currentCommand ^= action;
            return status;
        }

        public function hit(player:Player):void {
            
            this.currentState = Character.STATE_NAME_PUNCH;
            this.v.character.gotoAndPlay(Character.STATE_NAME_PUNCH);
            // this.currentState = Character.STATE_NAME_IDLE;
            this.disable = true;
            this.currentCommand = Command.COMMAND_HIT;
        }

        public function hitAttackReEnable(e:Event):void {
            this.v.character.removeEventListener(Character.EVENT_END_HIT, hitAttackReEnable);
            this.currentCommand = 0;
            this.disable = false;
            this.v.character.gotoAndPlay(Character.STATE_NAME_IDLE);
            if( this.id == 0 )
                this.fieldView.player2.health -= this.damage;
            else
                this.fieldView.player1.health -= this.damage;
        }

        private function die():void {
            this.v.character.addEventListener(Character.EVENT_END_DIE, endDie);
            this.v.character.gotoAndPlay(Character.STATE_NAME_DIE);
            this.currentCommand = 0;
            this.disable = true;
        }

        private function endDie(e:Event):void {
            this.health = START_HEALTH;
            this.currentCommand = 0;
            this.currentState = Character.STATE_NAME_IDLE;
            this.disable = false;
            this.v.character.gotoAndPlay(Character.STATE_NAME_IDLE);
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
    }
}