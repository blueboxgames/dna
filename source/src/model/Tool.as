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
        public function Tool(x:int, y:int, repairs:int)
        {
            this.v = new ToolView();
            this.x = x;
            this.y = y;
            this.repairs = repairs;
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

        public function repair(repairable:Repairable):Boolean
        {
            if( this.repairs == 0 || this.repairs == repairable.id )
            {
                repairable.repaired = true;
                return true;
            }
            return false;
        }
    }
}