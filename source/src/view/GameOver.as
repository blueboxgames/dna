package view {
import control.InputController;

import flash.display.Sprite;

import utils.IState;
import utils.MyEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;

public class GameOver extends Sprite implements IState {
    private var winner:int;
    public function GameOver(input:InputController) {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        this.addEventListener(MyEvent.REQUEST_STATE, onRequest_state);
    }

    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        var playBtn:ButtonRed = new ButtonRed();
        playBtn.text_field.text = "Play Again";
        playBtn.x = (stage.stageWidth - playBtn.width) / 2;
        playBtn.y = (stage.stageHeight - playBtn.height) / 2 + 100;
        addChild(playBtn);
        playBtn.addEventListener(MouseEvent.CLICK, onClickPlay);
        
        if( FieldView.winner == 0 )
        {
            // Blue
            var bluewin:Bitmap = new Assets.WIN_BLUE();
            bluewin.scaleX = bluewin.scaleY = 0.1;
            bluewin.x = playBtn.x;
            bluewin.y = (this.stage.stageHeight * 0.1 );
            this.addChild(bluewin);
        }
        else
        {
            var redwin:Bitmap = new Assets.WIN_RED();
            redwin.scaleX = redwin.scaleY = 0.1;
            redwin.x = playBtn.x;
            redwin.y = (this.stage.stageHeight * 0.1 );
            this.addChild(redwin);
        }

    }

    private function onClickPlay(event:MouseEvent):void {
        FieldView.winner = 0;
        dispatchEvent(new MyEvent(MyEvent.REQUEST_STATE, false, {state: Battle}));
    }

    private function onRequest_state(event:MyEvent):void {
        this.removeEventListener(MyEvent.REQUEST_STATE, onRequest_state);
        
    }

    public function update():void {
    }

    public function destroy():void {
    }
}
}
