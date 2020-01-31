package view {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.setTimeout;

import model.Command;
import model.Player;
import model.Repairable;
import model.Tool;

import utils.CoreUtils;
import utils.MyEvent;

public class FieldView extends Sprite {
    public static const PLAYER1_START_X:int = 550;
    public static const PLAYER1_START_Y:int = 800;
    public static const PLAYER2_START_X:int = 790;
    public static const PLAYER2_START_Y:int = 430;

    public static var winner:int;
    public var player1:Player;
    public var player2:Player;
    private var tools:Array;
    private var objects:Array;

    private var _id:int;
    private var _bg:Bitmap;

    public function FieldView(id:int) {
        _bg = new Assets.BG_TEXTURE;
        this.addChild(_bg);
        _id = id;
        this.tools = [];
        this.objects = [];
        winner = 0;
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

        var repairable1:Repairable = new Repairable(450, 500, Repairable.TYPE_CAR, 0, Repairable.REPAIR_STATE_TWO);
        var repairable2:Repairable = new Repairable(1200, 700, Repairable.TYPE_FAN, 0, Repairable.REPAIR_STATE_TWO);
        var repairable3:Repairable = new Repairable(1700, 200, Repairable.TYPE_TV,  0, Repairable.REPAIR_STATE_TWO);
        this.objects.push(repairable1);
        this.addChild(repairable1.v);
        this.objects.push(repairable2);
        this.addChild(repairable2.v);
        this.objects.push(repairable3);
        this.addChild(repairable3.v);

        this.addTool(new Tool(120, 550, Tool.TYPE_CAR_1, Repairable.TYPE_CAR));
        this.addTool(new Tool(800, 300, Tool.TYPE_CAR_1, Repairable.TYPE_CAR));
        this.addTool(new Tool(346, 1700, Tool.TYPE_FAN_1, Repairable.TYPE_FAN));
        this.addTool(new Tool(989, 346, Tool.TYPE_FAN_2, Repairable.TYPE_FAN));
        this.addTool(new Tool(232, 555, Tool.TYPE_TV_1, Repairable.TYPE_TV));
        this.addTool(new Tool(423, 1203, Tool.TYPE_TV_2, Repairable.TYPE_TV));
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
    }


    private function playerChange_eventHandler(e:Event):void {
        var p:Player = e.currentTarget as Player;
        if( p.score == 2 )
        {
            winner = p.id;
            this.dispatchEvent(new MyEvent(MyEvent.GAME_OVER, false));
        }
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

        if (this.stage == null)
            return;

        if (_id == 1) {
            this.x = (stage.stageWidth * 1 / 4) - player1.x;
            this.y = (stage.stageHeight / 2) - player1.y;
        } else if (_id == 2) {
            this.x = (stage.stageWidth * 3 / 4) - player2.x;
            this.y = (stage.stageHeight / 2) - player2.y;
        }
        if(this.x >= 0)
            this.x = 0;
        if(this.y >= 0)
            this.y = 0;
        if(this.x <= -_bg.width + stage.stageWidth / 2)
            this.x = -_bg.width + stage.stageWidth / 2;
        if(this.y <= -_bg.height + stage.stageHeight)
            this.y = -_bg.height + stage.stageHeight;

        if(player1.x <= 0)
            player1.x = 0;
        if(player1.y <= 0)
            player1.y = 0;
        if(player1.x >= _bg.width)
            player1.x = _bg.width;
        if(player1.y >= _bg.height)
            player1.y = _bg.height;

        if(player2.x <= 0)
            player2.x = 0;
        if(player2.y <= 0)
            player2.y = 0;
        if(player2.x >= _bg.width)
            player2.x = _bg.width;
        if(player2.y >= _bg.height)
            player2.y = _bg.height;
    }
}
}