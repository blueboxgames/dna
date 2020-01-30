package view
{
    import flash.display.Sprite;

    public class PlayerView extends Sprite
    {
        private const DEBUG:Boolean = true;
        public function PlayerView(id:int)
        {
            if( DEBUG )
            {
                if( id == 0 )
                    this.graphics.beginFill(0xff0000);
                else
                    this.graphics.beginFill(0x0000ff);

                this.graphics.drawRect(0,0,30,60);
                this.graphics.endFill();
            }
        }
    }
}