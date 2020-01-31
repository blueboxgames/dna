package view
{
    import flash.display.Sprite;
    import model.Repairable;
    import flash.display.Bitmap;

    public class RepairableView extends Sprite
    {
        private const DEBUG:Boolean = true;
        private var graphic:Bitmap;
        private var type:int;

        private var _state:int;
        
        public function get state():int
        {
            return _state;
        }
        
        public function set state(value:int):void
        {
            if( value == 0 )
                return;
            _state = value;
            trace(state);
            trace(type);
            if( type == Repairable.TYPE_FAN )
            {
                if( state == Repairable.REPAIR_STATE_ONE )
                    this.graphic = new Assets.FAN_D2();
                else if( state == Repairable.REPAIR_STATE_TWO )
                    this.graphic = new Assets.FAN_D3();

                graphic.scaleX = graphic.scaleY = 0.2;
            }
            
            if( type == Repairable.TYPE_TV )
            {
                if( state == Repairable.REPAIR_STATE_ONE )
                    this.graphic = new Assets.TV_D2();
                else if( state == Repairable.REPAIR_STATE_TWO )
                    this.graphic = new Assets.TV_D3();

                graphic.scaleX = graphic.scaleY = 0.05;

            }
            
            if( type == Repairable.TYPE_CAR )
            {
                if( state == Repairable.REPAIR_STATE_ONE )
                    this.graphic = new Assets.CAR_D2();
                else if( state == Repairable.REPAIR_STATE_TWO )
                    this.graphic = new Assets.CAR_D3();

                graphic.scaleX = graphic.scaleY = 0.3;
            }

            
            this.removeChildren();
            this.addChild(this.graphic);
        }
        public function RepairableView(type:int)
        {
            this.type = type;
            if( type == Repairable.TYPE_FAN )
            {
                graphic = new Assets.FAN_D1();
                graphic.scaleX = graphic.scaleY = 0.2;
            }

            if( type == Repairable.TYPE_CAR )
            {
                graphic = new Assets.CAR_D1();
                graphic.scaleX = graphic.scaleY = 0.3;
            }

            if( type == Repairable.TYPE_TV )
            {
                graphic = new Assets.TV_D1();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            this.addChild(graphic);
        }
    }
}