package view {
import control.InputController;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import model.Command;
import flash.display.Bitmap;

import utils.IState;
import utils.MyEvent;

public class Battle extends Sprite implements IState {
    public var field1:FieldView;
    public var field2:FieldView;

    public function Battle(input:InputController) {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        this.stage.addEventListener(KeyboardEvent.KEY_UP, keyup_eventHandler);
        this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_eventHandler);

        this.field1 = new FieldView(1);
        this.field1.x = 0;
        this.field1.addRepairable(50, 50);
        this.stage.addChild(field1);
        this.field1.initialize();

        var mask1:Shape = new Shape();
        mask1.graphics.beginFill(0);
        mask1.graphics.drawRect(0, 0, stage.stageWidth / 2, stage.stageHeight);
        mask1.graphics.endFill();
        field1.mask = mask1;

        this.field2 = new FieldView(2);
        this.field2.addRepairable(50, 50);
        this.field2.x = stage.stageWidth / 2;
        this.stage.addChild(field2);
        this.field2.initialize();

        var mask2:Shape = new Shape();
        mask2.graphics.beginFill(0);
        mask2.graphics.drawRect(stage.stageWidth / 2, 0, stage.stageWidth / 2, stage.stageHeight);
        mask2.graphics.endFill();
        field2.mask = mask2;
    }

    private function onInputStart1(event:MyEvent):void {
         switch (event.data.action) {
            case InputController.MOVE_RIGHT:
                this.field1.player1.execute(Command.COMMAND_RIGHT);
                this.field2.player1.execute(Command.COMMAND_RIGHT);
                break;
            case InputController.MOVE_LEFT:
                this.field1.player1.execute(Command.COMMAND_LEFT);
                this.field2.player1.execute(Command.COMMAND_LEFT);
                break;
            case InputController.MOVE_UP:
                this.field1.player1.execute(Command.COMMAND_UP);
                this.field2.player1.execute(Command.COMMAND_UP);
                break;
            case InputController.MOVE_DOWN:
                this.field1.player1.execute(Command.COMMAND_DOWN);
                this.field2.player1.execute(Command.COMMAND_DOWN);
                break;
        }
    }

    public function keyup_eventHandler(e:KeyboardEvent):void {
        if (e.keyCode == Keyboard.UP) {
            this.field1.player1.unexecute(Command.COMMAND_UP);
            this.field2.player1.unexecute(Command.COMMAND_UP);
        } else if (e.keyCode == Keyboard.DOWN) {
            this.field1.player1.unexecute(Command.COMMAND_DOWN);
            this.field2.player1.unexecute(Command.COMMAND_DOWN);
        } else if (e.keyCode == Keyboard.LEFT) {
            this.field1.player1.unexecute(Command.COMMAND_LEFT);
            this.field2.player1.unexecute(Command.COMMAND_LEFT);

        } else if (e.keyCode == Keyboard.RIGHT) {
            this.field1.player1.unexecute(Command.COMMAND_RIGHT);
            this.field2.player1.unexecute(Command.COMMAND_RIGHT);

        } else if (e.keyCode == 13) {
            this.field1.player1.unexecute(Command.COMMAND_ACTION)
            this.field2.player1.unexecute(Command.COMMAND_ACTION)

        } else if (e.keyCode == Keyboard.NUMPAD_ADD) {
            this.field1.player1.unexecute(Command.COMMAND_HIT);
            this.field2.player1.unexecute(Command.COMMAND_HIT);

        } else if (e.keyCode == Keyboard.W) {
            this.field1.player2.unexecute(Command.COMMAND_UP);
            this.field2.player2.unexecute(Command.COMMAND_UP);
        } else if (e.keyCode == Keyboard.S) {
            this.field1.player2.unexecute(Command.COMMAND_DOWN);
            this.field2.player2.unexecute(Command.COMMAND_DOWN);

        } else if (e.keyCode == Keyboard.A) {
            this.field1.player2.unexecute(Command.COMMAND_LEFT);
            this.field2.player2.unexecute(Command.COMMAND_LEFT);

        } else if (e.keyCode == Keyboard.D) {
            this.field1.player2.unexecute(Command.COMMAND_RIGHT);
            this.field2.player2.unexecute(Command.COMMAND_RIGHT);
        } else if (e.keyCode == Keyboard.SPACE) {
            this.field1.player2.unexecute(Command.COMMAND_ACTION);
            this.field2.player2.unexecute(Command.COMMAND_ACTION);
        } else if (e.keyCode == Keyboard.E) {
            this.field1.player2.unexecute(Command.COMMAND_HIT);
            this.field2.player2.unexecute(Command.COMMAND_HIT);
        }
    }

    public function keydown_eventHandler(e:KeyboardEvent):void {
        if (e.keyCode == Keyboard.UP) {
            this.field1.player1.execute(Command.COMMAND_UP);
            this.field2.player1.execute(Command.COMMAND_UP);
        } else if (e.keyCode == Keyboard.DOWN) {
            this.field1.player1.execute(Command.COMMAND_DOWN);
            this.field2.player1.execute(Command.COMMAND_DOWN);
        } else if (e.keyCode == Keyboard.LEFT) {

            this.field1.player1.execute(Command.COMMAND_LEFT);
            this.field2.player1.execute(Command.COMMAND_LEFT);
        } else if (e.keyCode == Keyboard.RIGHT) {
            this.field1.player1.execute(Command.COMMAND_RIGHT);
            this.field2.player1.execute(Command.COMMAND_RIGHT);

        } else if (e.keyCode == 13) {
            this.field1.player1.execute(Command.COMMAND_ACTION);
            this.field2.player1.execute(Command.COMMAND_ACTION);
        } else if (e.keyCode == Keyboard.NUMPAD_ADD) {
            this.field1.player1.execute(Command.COMMAND_HIT);
            this.field2.player1.execute(Command.COMMAND_HIT);

        } else if (e.keyCode == Keyboard.W) {

            this.field1.player2.execute(Command.COMMAND_UP);
            this.field2.player2.execute(Command.COMMAND_UP);
        } else if (e.keyCode == Keyboard.S) {
            this.field1.player2.execute(Command.COMMAND_DOWN);
            this.field2.player2.execute(Command.COMMAND_DOWN);

        } else if (e.keyCode == Keyboard.A) {
            this.field1.player2.execute(Command.COMMAND_LEFT);
            this.field2.player2.execute(Command.COMMAND_LEFT);

        } else if (e.keyCode == Keyboard.D) {
            this.field1.player2.execute(Command.COMMAND_RIGHT);
            this.field2.player2.execute(Command.COMMAND_RIGHT);

        } else if (e.keyCode == Keyboard.SPACE) {

            this.field1.player2.execute(Command.COMMAND_ACTION);
            this.field2.player2.execute(Command.COMMAND_ACTION);
        } else if (e.keyCode == Keyboard.E) {

            this.field1.player2.execute(Command.COMMAND_HIT);
            this.field2.player2.execute(Command.COMMAND_HIT);
        }
    }

    public function update():void {
        this.field1.update();
        this.field2.update();
    }

    public function destroy():void {
    }
}
}
