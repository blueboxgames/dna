package model
{
    import view.RepairableView;

    public class Repairable
    {
        public static const REPAIR_STATE_NONE:int  = 0x0;
        public static const REPAIR_STATE_ONE:int   = 0x1;
        public static const REPAIR_STATE_TWO:int   = 0x2;
        public static const REPAIR_STATE_THREE:int = 0x4;
        public static const REPAIR_STATE_FOUR:int  = 0x8;

        public static const TYPE_RADIO:int = 0x0;
        public static const TYPE_TV:int = 0x1;
        public static const TYPE_CAR:int = 0x2;

        public var id:int = 1;
        public var v:RepairableView;
        public var repaired:Boolean = false;
        public var screwReq:int;
        public var maxRepairState:int;

        private var _type:int;
        
        public function get type():int
        {
            return _type;
        }
        
        public function set type(value:int):void
        {
            _type = value;
        }

        private var _currentRepairState:int;
        
        public function get currentRepairState():int
        {
            return _currentRepairState;
        }
        
        public function set currentRepairState(value:int):void
        {
            _currentRepairState = value;
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
        
        public function Repairable(x:int, y:int, type:int, screwReq:int, maxRepState:int) {
            this.v = new RepairableView();
            this.x = x;
            this.y = y;
            this.type = type;
            this.screwReq = screwReq;
            this.maxRepairState = maxRepairState;
            this.currentRepairState = REPAIR_STATE_NONE;
        }

        public function checkRepair():Boolean
        {
            if( this.screwReq == 0 && this.currentRepairState == this.maxRepairState )
                return true;
            return false;
        }

        public function repair(tool:Tool):Boolean
        {
            if( checkRepair() == true )
                return false;
            
            if( tool.repairs == 0 )
            {
                this.screwReq--;
                return true;
            }

            if( tool.repairs == this.type )
            {
                this.currentRepairState |= tool.state;
                return true;
            }

            if( checkRepair() )
            {
                this.repaired = true;
                return false;
            }
            return false;
        }
    }
}