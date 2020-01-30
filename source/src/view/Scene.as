package view
{
  import com.grantech.colleagues.Colleague;
  import com.grantech.colleagues.Colleagues2d;
  import com.grantech.colleagues.Contacts;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.utils.getTimer;

  public class Scene extends Sprite
  {
    static public const WIDTH:int = 300;
    static public const HEIGHT:int = 200;
    static public const BORDER:int = 20; 
    static public const PADDING:int = 10; 
    static public const CAMERA_WIDTH:int = 400; 
    static public const CAMERA_HEIGHT:int = 600; 

    private var dt:int;
    private var accumulator:int;
    private var engine:Colleagues2d;

    public function Scene()
    {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
    }

    protected function addedToStageHandler(event:Event):void
    {
      this.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);

      this.engine = new Colleagues2d(1/stage.frameRate);

      var leftWall:Wall  = new Wall(-BORDER * 0.5 + PADDING, HEIGHT * 0.5, BORDER, HEIGHT + BORDER * 2, this);
      this.engine.colleagues.push(leftWall);
      var rightWall:Wall = new Wall(WIDTH + BORDER * 0.5 - PADDING, HEIGHT * 0.5, BORDER, HEIGHT + BORDER * 2, this);
      this.engine.colleagues.push(rightWall);
      var topWall:Wall   = new Wall(WIDTH * 0.5, -BORDER * 0.5 + PADDING, WIDTH + BORDER * 2, BORDER, this);
      this.engine.colleagues.push(topWall);
      var bottomWall:Wall= new Wall(WIDTH * 0.5, HEIGHT + BORDER * 0.5 - PADDING, WIDTH + BORDER * 2, BORDER, this);
      this.engine.colleagues.push(bottomWall);

      this.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
	  	this.stage.addEventListener(MouseEvent.CLICK, this.stage_clickHandler);
    }

    private function stage_clickHandler(event:MouseEvent):void
    {
      var mx:int = Math.round(event.stageX);
      var my:int = Math.round(event.stageY);
      var min:int = 10;
      var max:int = 30;
      var b:Colleague;
      if (event.shiftKey) {
        b = this.engine.add(Shape.create_box(random(min, max), random(min, max)), mx, my);
        if (event.ctrlKey)
          b.setStatic();
      } else {
        addUnit(random(min, max), random(50, 150), mx, my);
      }
    }

    private function random(min:Number, max:Number):Number {
      return min + Math.random() * (max - min);
    }

    protected function addUnit(size:Number, speed:Number, x:int, y:int):void
    {
      var u:Unit = new Unit(x, y, size, this);
      this.engine.colleagues.push(u);
      u.speed = speed;
      // u.side = b.y > stage.stageHeight * 0.5 ? 0 : 1;
    }
  
    protected function enterFrameHandler(event:Event):void
    {
      var t:int = getTimer();
      this.accumulator += (t - this.dt);
      this.dt = t;
      if (this.accumulator >= this.engine.deltaTime)
      {
        this.accumulator -= this.engine.deltaTime;
        this.engine.step();
      }

      for each(var c:Colleague in engine.colleagues)
      {
        if(c.mass == 0)
        continue;
        var u:Unit = c as Unit;
        u.skin.x = u.x;
        u.skin.y = u.y;
      }
    }
    }
  }
}