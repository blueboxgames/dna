package view {
import control.InputController;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.setTimeout;

import utils.IState;
import utils.MyEvent;

public class SplashScreen extends Sprite implements IState {
    public function SplashScreen(input:InputController) {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        var logo:Bitmap = new Assets.Logo();
        logo.x = (stage.stageWidth - logo.width) / 2;
        logo.y = (stage.stageHeight - logo.height) / 2;
        addChild(logo);

        setTimeout(gotoMenu, 3000);
    }

    private function gotoMenu():void {
        this.dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, true, {state: Menu}));
    }

    public function update():void {
    }

    public function destroy():void {
    }
}
}
