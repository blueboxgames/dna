package view
{
    import flash.display.Sprite;
    import flash.display.MovieClip;

    public class PlayerView extends Sprite
    {
        private const DEBUG:Boolean = true;
        public var character:MovieClip;
        public function PlayerView(id:int)
        {
            if( DEBUG )
            {
                character = new CharacterBlue();
                if( id == 0 )
                {
                    character.scaleX = character.scaleY = 0.1;
                    this.addChild(character)
                }
                else
                    this.graphics.beginFill(0x0000ff);

                this.graphics.drawRect(0,0,30,60);
                this.graphics.endFill();
            }
        }
    }
}