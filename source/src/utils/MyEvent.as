package utils {
import flash.events.Event;

public class MyEvent extends Event {
    public static const REQUEST_STATE:String = "requestState";
    public static const INPUT_MOVE_RIGHT:String = "inputRight";
    public static const INPUT_MOVE_LEFT:String = "inputLeft";
    public static const INPUT_MOVE_UP:String = "inputUp";
    public static const INPUT_MOVE_DOWN:String = "inputDown";
    public static const INPUT_PICK_DROP:String = "inputPickDrop";
    public static const INPUT_HIT:String = "inputHit";

    private var _data:Object;

    public function MyEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, false);
        this._data = data;
    }

    public function get data():Object {
        return _data;
    }
}
}
