package
{
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import model.Command;
    import view.PlayerView;
    import model.Tool;
    import model.Repairable;

    public class Main extends Sprite
    {
        public var player1:PlayerView;
        public var player2:PlayerView;

        public function Main()
        {
            this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup_eventHandler);
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_eventHandler);
            this.player1 = new PlayerView(0xff0000);
            this.player1.x = 200;
            this.player1.y = 200;
            this.stage.addChild(player1);
            this.player2 = new PlayerView(0x0000ff);
            this.stage.addChild(player2);

            var repairable1:Repairable = new Repairable();
            var tool1:Tool = new Tool(null, repairable1);
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
    }
}