package model
{
    import view.ToolView;

    public class Tool
    {
        public static const TYPE_SCREW:int = 0;
        public static const TYPE_FAN_1:int = 1;
        public static const TYPE_FAN_2:int = 2;
        public static const TYPE_TV_1:int = 3;
        public static const TYPE_TV_2:int = 4;
        public static const TYPE_CAR_1:int = 5;

        public var id:int;
        public var repairs:int;
        public var radiusX:int = 5;
        public var radiusY:int = 5;
        public var v:ToolView;
        public var state:int;
        public function Tool(x:int, y:int, type:int, repairs:int)
        {
            this.v = new ToolView(type);
            this.x = x;
            this.y = y;
            this.repairs = repairs;
            this.state = type;
        }

        private var _x:int;
        
        public function get x():int
        {
            return _x;
        }
        
        public function set x(value:int):void
        {
            _x = value;
            this.v.x = _x;
        }

        private var _y:int;
        
        public function get y():int
        {
            return _y;
        }
        
        public function set y(value:int):void
        {
            _y = value;
            this.v.y = _y;
        }
    }
}