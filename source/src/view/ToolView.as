package view
{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import model.Tool;

    public class ToolView extends Sprite
    {
        private const DEBUG:Boolean = true;
        private var graphic:Bitmap;
        public function ToolView(type:int)
        {
            if( type == Tool.TYPE_SCREW )
            {
                graphic = new Assets.Bolts();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            if( type == Tool.TYPE_TV_1 )
            {
                graphic = new Assets.TV1();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            if( type == Tool.TYPE_TV_2 )
            {
                graphic = new Assets.TV2();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            if( type == Tool.TYPE_FAN_1 )
            {
                graphic = new Assets.FAN1();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            if( type == Tool.TYPE_FAN_2 )
            {
                graphic = new Assets.FAN2();
                graphic.scaleX = graphic.scaleY = 0.05;
            }

            if( type == Tool.TYPE_CAR_1 )
            {
                graphic = new Assets.CAR1();
                graphic.scaleX = graphic.scaleY = 0.05;
            }
            
            this.addChild(graphic);
        }


    }
}