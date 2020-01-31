package utils {
import flash.events.Event;

public class MyEvent extends Event {
    public static const REQUEST_STATE:String = "requestState";
    public static const INPUT_START:String = "inputStart";
    public static const INPUT_END:String = "inputEnd";
    public static const GAME_OVER:String = "gameOver";
    public static const CHANGE_HEALTH:String = "changeHealth";

    private var _data:Object;
    public static const RESET_HEALTH:String = "resetHealth";

    public function MyEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, false);
        this._data = data;
    }

    public function get data():Object {
        return _data;
    }
}
}
