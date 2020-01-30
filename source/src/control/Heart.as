package control
{
    import flash.display.Sprite;
    import flash.display.Bitmap;

    public class Heart extends Sprite
    {
        private var graphic:Bitmap;
        public function Heart()
        {
            this.isFull = true;
            this.graphic = new Assets.HEART();
            this.addChild(this.graphic);
        }

        private var _isFull:Boolean;
        
        public function get isFull():Boolean
        {
            return _isFull;
        }
        
        public function set isFull(value:Boolean):void
        {
            if( value == _isFull )
                return;
            _isFull = value;
            if( _isFull )
                this.graphic = new Assets.HEART();
            else
                this.graphic = new Assets.HEART_EMPTY();
            
            trace("Here?");
            this.removeChildren();
            this.addChild(this.graphic);
        }
    }
}