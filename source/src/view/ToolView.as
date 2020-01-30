package view
{
    import flash.display.Sprite;

    public class ToolView extends Sprite
    {
        private const DEBUG:Boolean = true;
        public function ToolView()
        {
            if( DEBUG )
            {
                this.graphics.beginFill(0x00ff00);
                this.graphics.drawRect(0,0,30,50);
                this.graphics.endFill();
            }
        }
    }
}