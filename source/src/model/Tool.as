package model
{
    import flash.events.EventDispatcher;

    public class Tool extends EventDispatcher
    {
        public var id:int;
        public var repairs:int;
        public function Tool(repairs:int)
        {
            this.repairs = repairs;
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