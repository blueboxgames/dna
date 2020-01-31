package view
{
    import flash.display.Sprite;
    import flash.display.Bitmap;

    public class MiscView extends Sprite
    {
        public function MiscView()
        {
            var len:int = 30;
            for(var index:int = 0; index < len; index++)
            {
                var t1:Bitmap = new Assets.TREE1();
                var t2:Bitmap = new Assets.TREE2();
                var sel:Number = 0;
                if( Math.random() < 0.5 )
                    sel = 1;
                
                var x:int = Math.random() * 2000;
                var y:int = Math.random() * 2000;

                if( sel == 0 )
                {
                    t1.x = x;
                    t1.y = y;
                    this.addChild(t1);
                }
                else
                {
                    t2.x = x;
                    t2.y = y;
                    this.addChild(t2);
                }
            }
        }
    }
}