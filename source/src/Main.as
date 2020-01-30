package {
import flash.display.Sprite;

import utils.IState;

import view.Menu;

[SWF(width=800, height=800)]
public class Main extends Sprite {
    private var _currentState:IState;

    public function Main() {
        changeStateTo(Menu);
    }

    public function changeStateTo(state:Class):void {
        if (_currentState) {
            removeChild(_currentState as Sprite);
            _currentState.destroy();
            _currentState = null;
        }
        _currentState = new state();
        addChild(_currentState as Sprite);
    }
}
}