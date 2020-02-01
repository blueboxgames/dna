package {
import com.alexomara.ane.AIRControl.AIRControl;

import control.InputController;

import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;

import utils.IState;
import utils.MyEvent;

import view.Menu;

[SWF(width=800, height=480)]

public class Main extends Sprite {
    private var _currentState:IState;

    [Embed(source="font/ARLRDBD.TTF",
            fontName="Arial Rounded MT Bold",
            mimeType="application/x-font",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var _arialRoundedFont:Class;
    private var _inputControl:InputController;

    public function Main() {
        _inputControl = new InputController();
        changeStateTo(Menu);

        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
    }

    private function enterFrame_eventHandler(event:Event):void {
        AIRControl.update();
        if (_currentState) {
            _currentState.update();
        }
    }

    public function changeStateTo(state:Class):void {
        if (_currentState) {
            _currentState.destroy();
            removeChild(_currentState as Sprite);
            Sprite(_currentState).removeEventListener(MyEvent.REQUEST_STATE, onRequestState);
            _currentState = null;
        }
        _currentState = new state(_inputControl);
        Sprite(_currentState).addEventListener(MyEvent.REQUEST_STATE, onRequestState);
        addChild(_currentState as Sprite);
    }

    private function onRequestState(event:MyEvent):void {
        changeStateTo(event.data.state);
    }
}
}