package model
{
    import view.ToolView;

    public class Tool
    {
        public var id:int;
        public var repairs:int;
        public var radiusX:int = 5;
        public var radiusY:int = 5;
        public var v:ToolView;
        public var state:int;
        public function Tool(x:int, y:int, type:int, repairs:int)
        {
            this.v = new ToolView();
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