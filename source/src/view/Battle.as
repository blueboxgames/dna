package view {
import flash.display.Sprite;
import flash.events.Event;

import utils.IState;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import model.Command;

public class Battle extends Sprite implements IState{
    public var field1:FieldView;
    public var field2:FieldView;

    public function Battle() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup_eventHandler);
        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_eventHandler);

        /*
        camera2.x = 400;
        camera2.width = 400;
        camera2.height = 800; */
        this.field1 = new FieldView();
        this.field1.x = 0;
        this.field1.scaleX = 0.5;

        this.field2 = new FieldView();
        this.field2.addRepairable(50, 50);
        this.field2.addRepairable(100, 100);
        this.field2.x = 400;
        this.field2.scaleX = 0.5;
        this.stage.addChild(field1);
        this.stage.addChild(field2);
        this.field1.initialize();
        this.field2.initialize();
    }

    public function keyup_eventHandler(e:KeyboardEvent):void
    {
        if( e.keyCode == Keyboard.UP )
        {
            this.field1.player1.unexecute(Command.COMMAND_UP);
            this.field2.player1.unexecute(Command.COMMAND_UP);
        }
        else if( e.keyCode == Keyboard.DOWN )
        {
            this.field1.player1.unexecute(Command.COMMAND_DOWN);
            this.field2.player1.unexecute(Command.COMMAND_DOWN);
        }
        else if( e.keyCode == Keyboard.LEFT )
        {
            this.field1.player1.unexecute(Command.COMMAND_LEFT);
            this.field2.player1.unexecute(Command.COMMAND_LEFT);

        }
        else if( e.keyCode == Keyboard.RIGHT )
        {
            this.field1.player1.unexecute(Command.COMMAND_RIGHT);
            this.field2.player1.unexecute(Command.COMMAND_RIGHT);

        }
        else if( e.keyCode == 13)
        {
            this.field1.player1.unexecute(Command.COMMAND_ACTION)
            this.field2.player1.unexecute(Command.COMMAND_ACTION)

        }
        else if( e.keyCode == Keyboard.NUMPAD_ADD )
        {
            this.field1.player1.unexecute(Command.COMMAND_HIT);
            this.field2.player1.unexecute(Command.COMMAND_HIT);

        }
        else if( e.keyCode == Keyboard.W )
        {
            this.field1.player2.unexecute(Command.COMMAND_UP);
            this.field2.player2.unexecute(Command.COMMAND_UP);
        }
        else if( e.keyCode == Keyboard.S )
        {
            this.field1.player2.unexecute(Command.COMMAND_DOWN);
            this.field2.player2.unexecute(Command.COMMAND_DOWN);

        }
        else if( e.keyCode == Keyboard.A )
        {
            this.field1.player2.unexecute(Command.COMMAND_LEFT);
            this.field2.player2.unexecute(Command.COMMAND_LEFT);

        }
        else if( e.keyCode == Keyboard.D )
        {
            this.field1.player2.unexecute(Command.COMMAND_RIGHT);
this.field2.player2.unexecute(Command.COMMAND_RIGHT);
        }
        else if( e.keyCode == Keyboard.SPACE )
        {
            this.field1.player2.unexecute(Command.COMMAND_ACTION);
this.field2.player2.unexecute(Command.COMMAND_ACTION);
        }
        else if( e.keyCode == Keyboard.E )
        {
            this.field1.player2.unexecute(Command.COMMAND_HIT);
this.field2.player2.unexecute(Command.COMMAND_HIT);

        }
    }

    public function keydown_eventHandler(e:KeyboardEvent):void
    {
        if( e.keyCode == Keyboard.UP )
        {
            this.field1.player1.execute(Command.COMMAND_UP); this.field2.player1.execute(Command.COMMAND_UP);
        }
        else if( e.keyCode == Keyboard.DOWN )
        {
            this.field1.player1.execute(Command.COMMAND_DOWN); this.field2.player1.execute(Command.COMMAND_DOWN);
        }
        else if( e.keyCode == Keyboard.LEFT )
        {

            this.field1.player1.execute(Command.COMMAND_LEFT); this.field2.player1.execute(Command.COMMAND_LEFT);
        }
        else if( e.keyCode == Keyboard.RIGHT )
        {
            this.field1.player1.execute(Command.COMMAND_RIGHT); this.field2.player1.execute(Command.COMMAND_RIGHT);

        }
        else if( e.keyCode == 13 )
        {
            this.field1.player1.execute(Command.COMMAND_ACTION);this.field2.player1.execute(Command.COMMAND_ACTION);
        }
        else if( e.keyCode == Keyboard.NUMPAD_ADD )
        {
            this.field1.player1.execute(Command.COMMAND_HIT);this.field2.player1.execute(Command.COMMAND_HIT);

        }
        else if( e.keyCode == Keyboard.W )
        {

            this.field1.player2.execute(Command.COMMAND_UP);this.field2.player2.execute(Command.COMMAND_UP);
        }
        else if( e.keyCode == Keyboard.S )
        {
            this.field1.player2.execute(Command.COMMAND_DOWN);this.field2.player2.execute(Command.COMMAND_DOWN);

        }
        else if( e.keyCode == Keyboard.A )
        {
            this.field1.player2.execute(Command.COMMAND_LEFT);this.field2.player2.execute(Command.COMMAND_LEFT);

        }
        else if( e.keyCode == Keyboard.D )
        {
            this.field1.player2.execute(Command.COMMAND_RIGHT);this.field2.player2.execute(Command.COMMAND_RIGHT);

        }
        else if( e.keyCode == Keyboard.SPACE )
        {

            this.field1.player2.execute(Command.COMMAND_ACTION);this.field2.player2.execute(Command.COMMAND_ACTION);
        }
        else if( e.keyCode == Keyboard.E )
        {

            this.field1.player2.execute(Command.COMMAND_HIT);this.field2.player2.execute(Command.COMMAND_HIT);
        }
    }

    public function destroy():void {
    }
}
}
