package model
{
    import view.FieldView;
    import view.PlayerView;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import utils.CoreUtils;

    public class Player extends EventDispatcher
    {
        public function Player(id:int)
        {
            this.v = new PlayerView(id);
        }

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
        public var radiusX:int = 10;
        public var radiusY:int = 10;
        public var maxPickRadius:Number = 20;
        public var maxHitRadius:Number = 20;
        public var v:PlayerView;
        public var fieldView:FieldView;
        public var health:int = 3;
        public var damage:int = 1;

        public var speedFactor:int = 2;
        public var currentItem:Tool = null;
        public var anyDisable:Boolean = false;
        public var actionDisable:Boolean = false;
        public var currentState:String = CharacterBlue.STATE_NAME_IDLE;

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
            
            if( currentState == CharacterBlue.STATE_NAME_CARRY )
            {
                if( (_currentCommand & 0x000f) == 0x0 )
                    this.v.character.gotoAndPlay(CharacterBlue.STATE_NAME_IDLE_CARRY);
                else
                    this.v.character.gotoAndPlay(CharacterBlue.STATE_NAME_CARRY);
                return;
            }
            if( currentState == CharacterBlue.STATE_NAME_PUNCH )
                return;

            if( ( _currentCommand == 0 ) && currentState != CharacterBlue.STATE_NAME_IDLE )
            {
                this.v.character.gotoAndPlay(CharacterBlue.STATE_NAME_IDLE);
                currentState = CharacterBlue.STATE_NAME_IDLE;
            }
            if( (_currentCommand & 0x000f) != 0x0 && currentState != CharacterBlue.STATE_NAME_WALK )
            {
                this.v.character.gotoAndPlay(CharacterBlue.STATE_NAME_WALK);
                currentState = CharacterBlue.STATE_NAME_WALK;
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
        /* private var _currentCommand:int;
        
        public function get currentCommand():int
        {
            return _currentCommand;
        }
        
        public function set currentCommand(value:int):void
        {
            trace(_currentCommand);
            _currentCommand = value;
        } */
        
        /**
         * sets a command flag.
         */
        public function execute(action:int):int {
            if( this.anyDisable )
                return -1;
            var status:int = 0;
            if( (this.currentCommand & action) != action )
                this.currentCommand |= action;
            return status;
        }

        /**
         * unset a command flag.
         */
        public function unexecute(action:int):int {
            var status:int = 0;
            this.currentCommand ^= action;
            return status;
        }

        public function hit(player:Player):void {
            if( CoreUtils.getDistance(this.x, player.x, this.y, player.y) > this.maxHitRadius )
                return;
            
            // this.v.character.addEventListener(CharacterBlue.EVENT_HIT_END, hitAttackReEnable);
            this.v.character.gotoAndPlay(CharacterBlue.STATE_NAME_PUNCH);
            // this.anyDisable = true;
            this.currentState = CharacterBlue.STATE_NAME_IDLE;

        }

        public function hitAttackReEnable():void {
            // this.v.character.removeEventListener(CharacterBlue.EVENT_HIT_END);
            this.anyDisable = false;
        }
    }
}