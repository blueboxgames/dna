package
{
    import flash.display.Sprite;
    import view.FieldView;

    [SWF(width=800, height=800)]
    public class Main extends Sprite
    {
        public var field:FieldView;

        public function Main()
        {
            this.stage.stageWidth = 1200;
            this.stage.stageHeight = 1200;
            this.field = new FieldView();
            this.field.addRepairable(50, 50);
            this.field.addRepairable(100, 100);
            this.stage.addChild(this.field);
            this.field.initialize();
        }
    }
}