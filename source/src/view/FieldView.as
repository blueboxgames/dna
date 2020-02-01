package view {
import control.HeartGroup;

import flash.display.Sprite;
import flash.events.Event;
import flash.utils.setTimeout;

import model.Command;
import model.Player;
import model.Repairable;
import model.Tool;

import utils.CoreUtils;
import utils.MyEvent;
import com.grantech.colleagues.Colleagues2d;
import flash.events.MouseEvent;
import com.grantech.colleagues.Colleague;
import flash.utils.getTimer;

public class FieldView extends Sprite {
    public static const PLAYER1_START_X:int = 0;
    public static const PLAYER1_START_Y:int = 0;
    public static const PLAYER2_START_X:int = 600;
    public static const PLAYER2_START_Y:int = 600;

    public var player1:Player;
    public var player2:Player;
    private var tools:Array;
    private var objects:Array;

    private var _id:int;



    static public const WIDTH:int = 2000;
    static public const HEIGHT:int = 2000;
    static public const BORDER:int = 50; 
    static public const PADDING:int = 10; 

    private var dt:int;
    private var accumulator:int;
    private var engine:Colleagues2d;
   
    public function FieldView(id:int) {
        _id = id;
        this.tools = [];
        this.objects = [];
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

      /* var len:int = 4;
      for(var i:int = 0; i < len; i++)
        this.engine.colleagues.push(new Unit(Math.random()*(WIDTH - 100), Math.random()*(HEIGHT - 100), Math.random() * 8, this)); */

      this.stage.addEventListener(MouseEvent.CLICK, this.stage_clickHandler);
    }

    private function stage_clickHandler(event:MouseEvent):void
    {
        var mx:int = Math.round(event.stageX);
        var my:int = Math.round(event.stageY);
        var min:int = 10;
        var max:int = 30;
        addUnit(random(min, max), random(50, 150), mx, my);
        function random(min:Number, max:Number):Number {
            return min + Math.random() * (max - min);
        }
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
  
    private function updateEngine():void
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

    public function initialize():void {
        this.player1 = new Player(0);
        this.player1.x = PLAYER1_START_X;
        this.player1.y = PLAYER1_START_Y;
        this.player1.fieldView = this;
        player1.addEventListener(Event.CHANGE, playerChange_eventHandler);
        player1.addEventListener(MyEvent.CHANGE_HEALTH, playerChangeHealth);
        this.player2 = new Player(1);
        this.player2.x = PLAYER2_START_X;
        this.player2.y = PLAYER2_START_Y;
        this.player2.fieldView = this;
        player2.addEventListener(Event.CHANGE, playerChange_eventHandler);
        player2.addEventListener(MyEvent.CHANGE_HEALTH, playerChangeHealth);

        this.addChild(this.player1.v);
        this.addChild(this.player2.v);

        var repairable1:Repairable = new Repairable(450, 100, Repairable.TYPE_CAR, 0, Repairable.REPAIR_STATE_TWO);
        this.objects.push(repairable1);
        this.addChild(repairable1.v);

        this.addTool(new Tool(100, 100, Tool.TYPE_CAR_1, Repairable.TYPE_CAR));
        this.addTool(new Tool(100, 200, Tool.TYPE_CAR_1, Repairable.TYPE_CAR));
    }

    private function playerChangeHealth(event:MyEvent):void {
        dispatchEvent(new MyEvent(MyEvent.CHANGE_HEALTH, false, event.data));
    }

    public function playerPickCallback(player:Player):void {
        if (player.currentItem != null)
            return;
    }

    public function addTool(tool:Tool):void {
        this.tools.push(tool);
        this.addChild(tool.v);
    }

    public function addRepairable(x:int, y:int):void {
        /* var repairable:Repairable = new Repairable();
        repairable.id = this.repairables.length+2;
        this.repairables.push(repairable);

        var repairableView:Sprite = new Sprite();
        repairableView.graphics.beginFill(0x00ff00, 1);
        repairableView.graphics.drawRect(0, 0, 50, 50);
        repairableView.graphics.endFill();
        repairableView.x = x;
        repairableView.y = y;
        this.addChild(repairableView); */
    }


    private function playerChange_eventHandler(e:Event):void {
        var p:Player = e.currentTarget as Player;
    }

    private function step():void {
    }

    private function pItemPick(player:Player):void {
        var toolr:Tool = null;
        var minDist:Number = Number.MAX_VALUE;
        for each(var tool:Tool in tools) {
            var dist:Number = CoreUtils.getDistance(player.x, tool.x, player.y, tool.y);
            if (dist < minDist) {
                minDist = dist;
                toolr = tool;
            }
        }
        if (player.maxPickRadius < minDist || toolr == null)
            return;

        player.actionDisable = true;
        setTimeout(enableAPlayer, 1000, player);
        tools.removeAt(tools.indexOf(toolr));
        player.currentItem = toolr;
        this.removeChild(toolr.v);
        player.currentState = Character.STATE_NAME_CARRY;
        player.v.character.gotoAndPlay(Character.STATE_NAME_CARRY);
    }

    private function pItemDrop(player:Player):void {
        if (player.currentItem == null)
            return;

        // Check if near repairable
        var rep:Repairable = null;
        var minDist:Number = Number.MAX_VALUE;
        for each(var repairable:Repairable in this.objects) {
            var dist:Number = CoreUtils.getDistance(player.x, repairable.x, player.y, repairable.y);
            if (dist < minDist) {
                minDist = dist;
                rep = repairable;
            }
        }

        player.currentState = Character.STATE_NAME_IDLE;
        player.v.character.gotoAndPlay(Character.STATE_NAME_IDLE);
        if (player.maxPickRadius < minDist || rep == null) {
            player.currentItem.x = player.x;
            player.currentItem.y = player.y;
            this.tools.push(player.currentItem);
            this.addChild(player.currentItem.v);
            player.actionDisable = true;
            setTimeout(enableAPlayer, 1000, player);
            player.currentItem = null;
        } else {
            if (rep.repair(player.currentItem)) {
                player.currentItem = null;
                if (rep.repaired)
                    player.score++;
            }
        }
    }

    private function enableAPlayer(player:Player):void {
        player.actionDisable = false;
    }

    public function update():void {

        this.updateEngine();
        // Movement

        if (!player1.disable) {
            if ((player1.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP)
                player1.y -= player1.speedFactor;
            if ((player1.currentCommand & Command.COMMAND_RIGHT) == Command.COMMAND_RIGHT)
                player1.x += player1.speedFactor;
            if ((player1.currentCommand & Command.COMMAND_DOWN) == Command.COMMAND_DOWN)
                player1.y += player1.speedFactor;
            if ((player1.currentCommand & Command.COMMAND_LEFT) == Command.COMMAND_LEFT)
                player1.x -= player1.speedFactor;
        }

        if (!player2.disable) {
            if ((player2.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP)
                player2.y -= player2.speedFactor;
            if ((player2.currentCommand & Command.COMMAND_RIGHT) == Command.COMMAND_RIGHT)
                player2.x += player2.speedFactor;
            if ((player2.currentCommand & Command.COMMAND_DOWN) == Command.COMMAND_DOWN)
                player2.y += player2.speedFactor;
            if ((player2.currentCommand & Command.COMMAND_LEFT) == Command.COMMAND_LEFT)
                player2.x -= player2.speedFactor;
        }

        // Action
        if (!player1.actionDisable && !player1.disable) {
            if ((player1.currentCommand & Command.COMMAND_ACTION) == Command.COMMAND_ACTION) {
                if (player1.currentItem == null)
                    this.pItemPick(player1);
                else
                    this.pItemDrop(player1);
            }
        }

        if (!player2.actionDisable && !player2.disable) {
            if ((player2.currentCommand & Command.COMMAND_ACTION) == Command.COMMAND_ACTION) {
                if (player2.currentItem == null)
                    this.pItemPick(player2);
                else
                    this.pItemDrop(player2);
            }
        }

        // Hit
        if (!player1.disable) {
            if ((player1.currentCommand & Command.COMMAND_HIT) == Command.COMMAND_HIT) {
                player1.v.character.addEventListener(Character.EVENT_END_HIT, player1.hitAttackReEnable);
                player1.hit(player2);
            }
        }
        if (!player2.disable) {
            if ((player2.currentCommand & Command.COMMAND_HIT) == Command.COMMAND_HIT) {
                player2.v.character.addEventListener(Character.EVENT_END_HIT, player2.hitAttackReEnable);
                player2.hit(player1);
            }
        }

        if (_id == 1) {
            this.x = (stage.stageWidth * 1 / 4) - player1.x;
            this.y = (stage.stageHeight / 2) - player1.y;
        } else if (_id == 2) {
            this.x = (stage.stageWidth * 3 / 4) - player2.x;
            this.y = (stage.stageHeight / 2) - player2.y;
        }
    }
}
}