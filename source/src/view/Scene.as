package view
{
  import flash.display.Sprite;

  public class Scene extends Sprite
  {
    static public const WIDTH:int = 300;
    static public const HEIGHT:int = 200;
    static public const BORDER:int = 20; 
    static public const PADDING:int = 10; 
    static public const CAMERA_WIDTH:int = 400; 
    static public const CAMERA_HEIGHT:int = 600; 

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
    }
  }
}