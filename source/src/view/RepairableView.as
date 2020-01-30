package view
{
    import flash.display.Sprite;

    public class RepairableView extends Sprite
    {
        private const DEBUG:Boolean = true;
        public function RepairableView()
        {
            if( DEBUG )
            {
                this.graphics.beginFill(0x00ffff);
                this.graphics.drawRect(0,0,50,50);
                this.graphics.endFill();
            }
        }
    }
}