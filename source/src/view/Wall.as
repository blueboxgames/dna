package view
{
  import com.grantech.colleagues.Colleague;
  import com.grantech.colleagues.Shape;
  import flash.display.DisplayObjectContainer;
  import flash.display.Shape;

  public class Wall extends Colleague
  {
    public var skin:flash.display.Shape;
    public function Wall(x:int, y:int, width:int, height:int, parent:DisplayObjectContainer)
    {
      super(com.grantech.colleagues.Shape.create_box(width, height), x, y);
      this.setStatic();

      this.skin = new flash.display.Shape();
      this.skin.x = x;
      this.skin.y = y;
      this.skin.graphics.beginFill(0xFF00FF, 1.0);
      this.skin.graphics.drawRect(-width * 0.5, -height * 0.5, width, height);
      parent.addChild(this.skin);
    }
  }
}