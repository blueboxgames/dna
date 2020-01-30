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
                if( id == 0 )
                {
                    character = new CharacterBlue();
                    character.scaleX = character.scaleY = 0.1;
                    this.addChild(character)
                }
                else
                {
                    character = new CharacterRed();
                    character.scaleX = character.scaleY = 0.1;
                    this.addChild(character);
                }
            }
        }
    }
}