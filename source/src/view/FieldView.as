package view
{
    import flash.display.Sprite;
    import model.Repairable;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import model.Command;
    import flash.events.Event;

    public class FieldView extends Sprite
    {
        private var tools:Array;
        private var toolsView:Array;
        private var repairables:Array;
        private var player1:PlayerView;
        private var player2:PlayerView;

        public function FieldView()
        {
            this.tools = new Array();
            this.repairables = new Array();
        }

        public function initialize():void
        {
            this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup_eventHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_eventHandler);
            this.player1 = new PlayerView(0xff0000);
            this.player1.x = 200;
            this.player1.y = 200;
            this.player1.fieldView = this;
            this.stage.addChild(player1);
            this.player2 = new PlayerView(0x0000ff);
            this.player2.fieldView = this;
            this.stage.addChild(player2);
        }

        public function iPick(player:PlayerView):void
        {
            if( player.currentItem != null )
                return;
        }

        public function addTool(repairs:int):void
        {
            
        }

        public function addRepairable(x:int, y:int):void
        {
            var repairable:Repairable = new Repairable();
            repairable.id = this.repairables.length+2;
            this.repairables.push(repairable);

            var repairableView:Sprite = new Sprite();
            repairableView.graphics.beginFill(0x00ff00, 1);
            repairableView.graphics.drawRect(0, 0, 50, 50);
            repairableView.graphics.endFill();
            repairableView.x = x;
            repairableView.y = y;
            this.addChild(repairableView);
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
            else if( e.keyCode == Keyboard.NUMPAD_ENTER)
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
            else if( e.keyCode == Keyboard.NUMPAD_ENTER)
                player1.unexecute(Command.COMMAND_ACTION)
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

        private function enterFrame_eventHandler(e:Event):void
        {
            
        }
    }
}