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

    public class FieldView extends Sprite
    {
        public const PLAYER1_START_X:int = 0;
        public const PLAYER1_START_Y:int = 0;
        public const PLAYER2_START_X:int = 0;
        public const PLAYER2_START_Y:int = 0;

        private var player1:Player;
        private var player2:Player;
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
            this.player2 = new Player(1);
            this.player2.x = PLAYER2_START_X;
            this.player2.y = PLAYER2_START_Y;
            this.player2.fieldView = this;

            this.addChild(this.player1.v);
            this.addChild(this.player2.v);

            var tool1:Tool = new Tool(10, 10, 0);
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
                player1.execute(Command.COMMAND_ACTION)
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
        }

        private function pItemDrop(player:Player):void
        {
            if( player.currentItem == null )
                return;
            player.currentItem.x = player.x;
            player.currentItem.y = player.y;
            this.tools.push(player.currentItem);
            this.addChild(player.currentItem.v);
            player.actionDisable = true;
            setTimeout(enableAPlayer, 1000, player);
            player.currentItem = null;
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
        }
    }
}