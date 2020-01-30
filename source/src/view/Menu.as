package view {
import control.InputController;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import utils.IState;

import utils.MyEvent;

public class Menu extends Sprite implements IState{
    public function Menu(input:InputController) {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        var playBtn:ButtonRed = new ButtonRed();
        playBtn.text_field.text = "Play";
        playBtn.x = (stage.stageWidth - playBtn.width) / 2;
        playBtn.y = (stage.stageHeight - playBtn.height) / 2;
        addChild(playBtn);
        playBtn.addEventListener(MouseEvent.CLICK, onClickPlay);
    }

    private function onClickPlay(event:MouseEvent):void {
        dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, false, {state: Battle}));
    }

    private function onKeyUp(event:KeyboardEvent):void {
        switch (event.keyCode) {
            case Keyboard.SPACE:
                dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, false, {state: Battle}));
                break;
        }
    }

    public function update():void {
    }

    public function destroy():void {
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
}
}
