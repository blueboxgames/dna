package view {
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import utils.IState;

import utils.MyEvent;

public class Menu extends Sprite implements IState{
    public function Menu() {
        super();

        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    private function onKeyUp(event:KeyboardEvent):void {
        switch (event.keyCode) {
            case Keyboard.SPACE:
                dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, false, {state: Battle}));
                break;
        }
    }

    public function destroy():void {
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }
}
}
