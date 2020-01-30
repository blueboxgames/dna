package model
{
    import view.ToolView;

    public class Tool
    {
        public var id:int;
        public var x:int;
        public var y:int;
        public var repairs:int;
        public var radiusX:int = 5;
        public var radiusY:int = 5;
        public var v:ToolView;
        public function Tool(x:int, y:int, repairs:int)
        {
            this.x = x;
            this.y = y;
            this.repairs = repairs;
            this.v = new ToolView();
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