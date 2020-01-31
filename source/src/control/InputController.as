package control {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.GameInputEvent;
import flash.ui.GameInput;
import flash.ui.GameInputControl;
import flash.ui.GameInputDevice;

import utils.MyEvent;

public class InputController extends EventDispatcher {
    private var _gameInput:GameInput;

    public function InputController() {
        _gameInput = new GameInput();
        _gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, controllerAdded);
        _gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, controllerRemoved);
        _gameInput.addEventListener(GameInputEvent.DEVICE_UNUSABLE, controllerProblem);
    }

    private function controllerAdded(e:GameInputEvent):void {
        trace("controllerAdded:", GameInput.numDevices);
        var myDevice:GameInputDevice = GameInput.getDeviceAt(0);
        myDevice.enabled = true;
        for (var i:int = 0; i < myDevice.numControls; i++) {
            var c:GameInputControl = myDevice.getControlAt(i);//input reference (AXIS STICK, BUTTON, TRIGGER, etc) "0" is the 1st input
            c.addEventListener(Event.CHANGE, onChangeControl);
        }
    }

    private function onChangeControl(event:Event):void {
        var c:GameInputControl = event.target as GameInputControl;
        switch (c.id) {
            case "AXIS_0":
                if (c.value == 1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_MOVE_RIGHT));
                    trace(MyEvent.INPUT_MOVE_RIGHT);
                }
                if (c.value == -1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_MOVE_LEFT));
                    trace(MyEvent.INPUT_MOVE_LEFT);
                }
                break;
            case "AXIS_1":
                if (c.value == 1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_MOVE_DOWN));
                    trace(MyEvent.INPUT_MOVE_UP);
                }
                if (c.value == -1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_MOVE_UP));
                    trace(MyEvent.INPUT_MOVE_DOWN);
                }
                break;
            case "BUTTON_10":
                if (c.value == 1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_PICK_DROP));
                    trace(MyEvent.INPUT_PICK_DROP);
                }
                break;
            case "BUTTON_11":
                if (c.value == 1) {
                    dispatchEvent(new MyEvent(MyEvent.INPUT_HIT));
                    trace(MyEvent.INPUT_HIT);
                }
                break;
        }
//        trace("id: " + c.id);//the name of this control. Ex: "AXIS_0"
//        trace("value: " + c.value); //value of this control - Axis: -1 to 1, Button: 0 OR 1, Trigger: 0 to 1
//        trace("cont: " + c.device.name); //the name of the device. ie: "XBOX 360 Controller"
//        trace("device: " + c.device);
//        trace("minValue: " + c.minValue);//the minimum possible value for the control/input
//        trace("maxValue: " + c.maxValue);//the maximum possible value for the control/input
    }

    private function controllerRemoved(e:GameInputEvent):void {
    }

    private function controllerProblem(e:GameInputEvent):void {
    }

    public function get gameInput():GameInput {
        return _gameInput;
    }
}
}
