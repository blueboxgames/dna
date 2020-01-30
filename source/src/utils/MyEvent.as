package utils {
import flash.events.Event;

public class MyEvent extends Event {
    public static const REQUEST_STATE:String = "requestState";

    private var _data:Object;

    public function MyEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, false);
    }

    public function get data():Object {
        return _data;
    }
}
}
