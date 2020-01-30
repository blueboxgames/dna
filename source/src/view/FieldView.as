package view
{
    import flash.display.Sprite;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import model.Command;
    import flash.events.Event;
    import model.Player;
    import model.Tool;
    import utils.CoreUtils;
    import flash.utils.setTimeout;
    import model.Repairable;

    public class FieldView extends Sprite
    {
        public static const PLAYER1_START_X:int = 0;
        public static const PLAYER1_START_Y:int = 0;
        public static const PLAYER2_START_X:int = 600;
        public static const PLAYER2_START_Y:int = 600;

        public var player1:Player;
        public var player2:Player;
        private var tools:Array;
        private var objects:Array;

        public function FieldView()
        {
            this.tools = new Array();
            this.objects = new Array();
        }

        public function initialize():void
        {
            this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup_eventHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_eventHandler);
            this.player1 = new Player(0);
            this.player1.x = PLAYER1_START_X;
            this.player1.y = PLAYER1_START_Y;
            this.player1.fieldView = this;
            player1.addEventListener(Event.CHANGE, playerChange_eventHandler);
            this.player2 = new Player(1);
            this.player2.x = PLAYER2_START_X;
            this.player2.y = PLAYER2_START_Y;
            this.player2.fieldView = this;
            player2.addEventListener(Event.CHANGE, playerChange_eventHandler);

            this.addChild(this.player1.v);
            this.addChild(this.player2.v);

            var repairable1:Repairable = new Repairable(450, 100, Repairable.TYPE_TV, 1, Repairable.REPAIR_STATE_NONE);
            this.objects.push(repairable1);
            this.addChild(repairable1.v);
            var tool1:Tool = new Tool(100, 450, 0, 0);
            this.tools.push(tool1);
            this.addChild(tool1.v);
        }

        public function playerPickCallback(player:Player):void
        {
            if( player.currentItem != null )
                return;
        }

        public function addTool(repairs:int):void
        {
            
        }

        public function addRepairable(x:int, y:int):void
        {
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

        public function keyup_eventHandler(e:KeyboardEvent):void
        {
            if( e.keyCode == Keyboard.UP )
                player1.unexecute(Command.COMMAND_UP);
            else if( e.keyCode == Keyboard.DOWN )
                player1.unexecute(Command.COMMAND_DOWN);
            else if( e.keyCode == Keyboard.LEFT )
                player1.unexecute(Command.COMMAND_LEFT);
            else if( e.keyCode == Keyboard.RIGHT )
                player1.unexecute(Command.COMMAND_RIGHT);
            else if( e.keyCode == 13)
                player1.unexecute(Command.COMMAND_ACTION)
            else if( e.keyCode == Keyboard.NUMPAD_ADD )
                player1.unexecute(Command.COMMAND_HIT);
            else if( e.keyCode == Keyboard.W )
                player2.unexecute(Command.COMMAND_UP);
            else if( e.keyCode == Keyboard.S )
                player2.unexecute(Command.COMMAND_DOWN);
            else if( e.keyCode == Keyboard.A )
                player2.unexecute(Command.COMMAND_LEFT);
            else if( e.keyCode == Keyboard.D )
                player2.unexecute(Command.COMMAND_RIGHT);
            else if( e.keyCode == Keyboard.SPACE )
                player2.unexecute(Command.COMMAND_ACTION);
            else if( e.keyCode == Keyboard.E )
                player2.unexecute(Command.COMMAND_HIT);
        }

        public function keydown_eventHandler(e:KeyboardEvent):void
        {
            if( e.keyCode == Keyboard.UP )
                player1.execute(Command.COMMAND_UP);
            else if( e.keyCode == Keyboard.DOWN )
                player1.execute(Command.COMMAND_DOWN);
            else if( e.keyCode == Keyboard.LEFT )
                player1.execute(Command.COMMAND_LEFT);
            else if( e.keyCode == Keyboard.RIGHT )
                player1.execute(Command.COMMAND_RIGHT);
            else if( e.keyCode == 13 )
                player1.execute(Command.COMMAND_ACTION);
            else if( e.keyCode == Keyboard.NUMPAD_ADD )
                player1.execute(Command.COMMAND_HIT);
            else if( e.keyCode == Keyboard.W )
                player2.execute(Command.COMMAND_UP);
            else if( e.keyCode == Keyboard.S )
                player2.execute(Command.COMMAND_DOWN);
            else if( e.keyCode == Keyboard.A )
                player2.execute(Command.COMMAND_LEFT);
            else if( e.keyCode == Keyboard.D )
                player2.execute(Command.COMMAND_RIGHT);
            else if( e.keyCode == Keyboard.SPACE )
                player2.execute(Command.COMMAND_ACTION);
            else if( e.keyCode == Keyboard.E )
                player2.execute(Command.COMMAND_HIT);
        }

        private function playerChange_eventHandler(e:Event):void
        {
            var p:Player = e.currentTarget as Player;
        }

        private function step():void
        {
        }

        private function pItemPick(player:Player):void
        {
            var toolr:Tool = null;
            var minDist:Number = Number.MAX_VALUE;
            for each(var tool:Tool in tools)
            {
                var dist:Number = CoreUtils.getDistance(player.x, tool.x ,player.y, tool.y);
                if( dist < minDist )
                {
                    minDist = dist;
                    toolr = tool;
                }
            }
            if( player.maxPickRadius < minDist || toolr == null )
                return;
            
            player.actionDisable = true;
            setTimeout(enableAPlayer, 1000, player);
            tools.removeAt(tools.indexOf(toolr));
            player.currentItem = toolr;
            this.removeChild(toolr.v);
            player.currentState = Character.STATE_NAME_CARRY;
            player.v.character.gotoAndPlay(Character.STATE_NAME_CARRY);
        }

        private function pItemDrop(player:Player):void
        {
            if( player.currentItem == null )
                return;

            // Check if near repairable
            var rep:Repairable = null;
            var minDist:Number = Number.MAX_VALUE;
            for each(var repairable:Repairable in this.objects)
            {
                var dist:Number = CoreUtils.getDistance(player.x, repairable.x ,player.y, repairable.y);
                if( dist < minDist )
                {
                    minDist = dist;
                    rep = repairable;
                }
            }

            player.currentState = Character.STATE_NAME_IDLE;
            player.v.character.gotoAndPlay(Character.STATE_NAME_IDLE);
            if( player.maxPickRadius < minDist || rep == null )
            {
                player.currentItem.x = player.x;
                player.currentItem.y = player.y;
                this.tools.push(player.currentItem);
                this.addChild(player.currentItem.v);
                player.actionDisable = true;
                setTimeout(enableAPlayer, 1000, player);
                player.currentItem = null;
            }
            else
            {
                if( rep.repair(player.currentItem) )
                {
                    player.currentItem = null;
                    if( rep.repaired )
                        player.score++;
                }
            }
        }

        private function enableAPlayer(player:Player):void
        {
            player.actionDisable = false;
        }

        private function enterFrame_eventHandler(e:Event):void
        {
            // Movement
            if( (player1.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP )
                player1.y -= player1.speedFactor;
            if( (player1.currentCommand & Command.COMMAND_RIGHT ) == Command.COMMAND_RIGHT )
                player1.x += player1.speedFactor;
            if( (player1.currentCommand & Command.COMMAND_DOWN ) == Command.COMMAND_DOWN )
                player1.y += player1.speedFactor;
            if( (player1.currentCommand & Command.COMMAND_LEFT ) == Command.COMMAND_LEFT )
                player1.x -= player1.speedFactor;
            if( (player2.currentCommand & Command.COMMAND_UP) == Command.COMMAND_UP )
                player2.y -= player2.speedFactor;
            if( (player2.currentCommand & Command.COMMAND_RIGHT ) == Command.COMMAND_RIGHT )
                player2.x += player2.speedFactor;
            if( (player2.currentCommand & Command.COMMAND_DOWN ) == Command.COMMAND_DOWN )
                player2.y += player2.speedFactor;
            if( (player2.currentCommand & Command.COMMAND_LEFT ) == Command.COMMAND_LEFT )
                player2.x -= player2.speedFactor;

            // Action
            if( !player1.actionDisable )
            {
                if( (player1.currentCommand & Command.COMMAND_ACTION) == Command.COMMAND_ACTION )
                {
                    if( player1.currentItem == null )
                        this.pItemPick(player1);
                    else
                        this.pItemDrop(player1);
                }
            }

            if( !player2.actionDisable )
            {
                if( (player2.currentCommand & Command.COMMAND_ACTION) == Command.COMMAND_ACTION )
                {
                    if( player2.currentItem == null )
                        this.pItemPick(player2);
                    else
                        this.pItemDrop(player2);
                }
            }

            // Hit
            if( (player1.currentCommand & Command.COMMAND_HIT) == Command.COMMAND_HIT )
            {
                if( CoreUtils.getDistance(player1.x, player2.x, player2.y, player1.y) < player1.maxHitRadius )
                {
                    player1.v.character.addEventListener(Character.EVENT_END_HIT, player1.hitAttackReEnable);
                    player1.hit(player2);
                }
            }
            if( (player2.currentCommand & Command.COMMAND_HIT) == Command.COMMAND_HIT )
            {
                if( CoreUtils.getDistance(player1.x, player2.x, player2.y, player1.y) > player2.maxHitRadius )
                {
                    player2.v.character.addEventListener(Character.EVENT_END_HIT, player2.hitAttackReEnable);
                    player2.hit(player1);
                }
            }
        }
    }
}