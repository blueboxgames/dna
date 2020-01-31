package {
import flash.display.Sprite;

import utils.IState;
import utils.MyEvent;

import view.Menu;

[SWF(width=720, height=720, backgroundColor="#111111")]

public class Main extends Sprite {
    private var _currentState:IState;

    [Embed(source="font/ARLRDBD.TTF",
            fontName = "Arial Rounded MT Bold",
            mimeType = "application/x-font",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var arialRoundedFont:Class;

    public function Main() {
        changeStateTo(Menu);
    }

    public function changeStateTo(state:Class):void {
        if (_currentState) {
            _currentState.destroy();
            removeChild(_currentState as Sprite);
            Sprite(_currentState).removeEventListener(MyEvent.REQUEST_STATE, onRequestState);
            _currentState = null;
        }
        _currentState = new state();
        Sprite(_currentState).addEventListener(MyEvent.REQUEST_STATE, onRequestState);
        addChild(_currentState as Sprite);
    }

    private function onRequestState(event:MyEvent):void {
        changeStateTo(event.data.state);
    }
}
}