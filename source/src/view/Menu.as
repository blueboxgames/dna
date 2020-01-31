package view {
import control.InputController;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import utils.IState;

import utils.MyEvent;

public class Menu extends Sprite implements IState{
    private var _input:InputController;

    public function Menu(input:InputController) {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        _input = input;
        _input.addEventListener(MyEvent.INPUT_START, onInputStart);

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function gotoMenu():void {
        this.dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, true, {state: Menu}));
    }

    private function onInputStart(event:MyEvent):void {
        if (event.data.id == 0) {
            if (event.data.action == InputController.PICK_DROP) {
                dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, false, {state: Battle}));
            }
        }
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        var logo:Bitmap = new Assets.Logo();
        logo.scaleX = logo.scaleY = 0.75;
        logo.x = (stage.stageWidth - logo.width) / 2;
        logo.y = (stage.stageHeight - logo.height) / 3;
        addChild(logo);

        var playBtn:ButtonRed = new ButtonRed();
        playBtn.x = (stage.stageWidth - playBtn.width) / 2;
        playBtn.y = (stage.stageHeight - playBtn.height) * 3 / 4;
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
        _input.addEventListener(MyEvent.INPUT_START, onInputStart);
    }
}
}
