package model
{
    import view.FieldView;
    import view.PlayerView;
    import flash.events.EventDispatcher;
    import flash.events.Event;

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
        public var v:PlayerView;
        public var fieldView:FieldView;

        public var speedFactor:int = 1;
        public var currentItem:Tool = null;
        public var currentCommand:int = 0;
        public var actionDisable:Boolean = false;

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
            var status:int = 0;
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
    }
}