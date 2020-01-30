package view
{
  import com.grantech.colleagues.CMath;
  import com.grantech.colleagues.Colleague;
  import com.grantech.colleagues.Colleagues2d;
  import com.grantech.colleagues.Contacts;
  import com.grantech.colleagues.Shape;

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

      this.engine = new Colleagues2d(1000/stage.frameRate);

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
      u.speedX = Math.random() * 0.1 * (Math.random()>0.5?1:-1);
      u.speedY = Math.random() * 0.1 * (Math.random()>0.5?1:-1);
      // trace(u.speedX, u.speedY)
      this.engine.colleagues.push(u);
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
      // debugDraw();

      for each(var c:Colleague in engine.colleagues)
      {
        if(c.mass == 0)
        continue;
        var u:Unit = c as Unit;
        u.skin.x = u.x;
        u.skin.y = u.y;
      }
    }
        
    private function draw():void {
      this.graphics.clear();
      // if (skipDrawing)
      //   return;
      var x:Number = 0;
      var y:Number = 0;
      for each (var b:Colleague in this.engine.colleagues) {
        if (b.shape.type == Shape.TYPE_CIRCLE) {
          this.graphics.lineStyle(1, b.speedX == 0 && b.speedY == 0 ? 0xAAAAAA : 0xFF0000);
          this.graphics.moveTo(b.x, b.y);
          // this.graphics.lineTo(b.position.x + b.shape.radius * Math.cos(b.orient), b.position.y + b.shape.radius * Math.sin(b.orient));
          this.graphics.drawCircle(b.x, b.y, b.shape.radius);
        } else {
          this.graphics.lineStyle(1, 0x0000FF);
          for (var i:int=0; i < b.shape.vertexCount; i++) {
            // var v = new Vec2(b.shape.vertices[i].x, b.shape.vertices[i].y);
            // b.shape.u.muli(v);
            // v.addi(b.position);
            x = CMath.matrix_transformX(b.shape.matrix, b.shape.getX(i), b.shape.getY(i)) + b.x;
            y = CMath.matrix_transformY(b.shape.matrix, b.shape.getX(i), b.shape.getY(i)) + b.y;
            if (i == 0)
              this.graphics.moveTo(x, y);
            else
              this.graphics.lineTo(x, y);
          }
          x = CMath.matrix_transformX(b.shape.matrix, b.shape.getX(0), b.shape.getY(0)) + b.x;
          y = CMath.matrix_transformY(b.shape.matrix, b.shape.getX(0), b.shape.getY(0)) + b.y;
          this.graphics.lineTo(x, y);
        }
      }

      this.graphics.lineStyle(1, 0xAAAAAA);
      for each (var c:Contacts in engine.contacts) {
      //   if (c.count > 0 && c.a.shape.type == Shape.TYPE_CIRCLE && c.b.shape.type == Shape.TYPE_CIRCLE && c.a.side != c.b.side) {
      //     engine.colleagues.remove(c.a);
      //     engine.colleagues.remove(c.b);
      //     continue;
      //   }
        for (i=0; i < c.count; i++) {
          this.graphics.moveTo(c.getPointX(i), c.getPointY(i));
          this.graphics.lineTo(c.getPointX(i) + c.normalX * 4, c.getPointY(i) + c.normalY * 4);
        }
      }

    }
  }
}