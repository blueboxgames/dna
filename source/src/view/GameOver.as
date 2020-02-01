package view {
import control.InputController;

import flash.display.Sprite;

import utils.IState;
import utils.MyEvent;
import flash.events.Event;
import flash.events.MouseEvent;

public class GameOver extends Sprite implements IState {
    public function GameOver(input:InputController) {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        var playBtn:ButtonRed = new ButtonRed();
        // playBtn.text_field.text = "Game Over";
        playBtn.x = (stage.stageWidth - playBtn.width) / 2;
        playBtn.y = (stage.stageHeight - playBtn.height) / 2;
        addChild(playBtn);
    }

    public function update():void {

    }

    public function destroy():void {

    }
}
}
