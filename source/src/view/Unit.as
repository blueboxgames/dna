package view
{
  import com.grantech.colleagues.Colleague;
  import com.grantech.colleagues.Shape;

  import flash.display.DisplayObjectContainer;
  import flash.display.Shape;

  public class Unit extends Colleague
  {
    public var skin:flash.display.Shape;
    public function Unit(x:int, y:int, radius:int, parent:DisplayObjectContainer)
    {
      super(com.grantech.colleagues.Shape.create_circle(radius), x, y);

      this.skin = new flash.display.Shape();
      this.skin.x = x;
      this.skin.y = y;
      this.skin.graphics.beginFill(Math.random()*0xFFFFFF, Math.random() * 1.0);
      this.skin.graphics.drawCircle(0, 0, radius);
      parent.addChild(this.skin);
    }
  }
}