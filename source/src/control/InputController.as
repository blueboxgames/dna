package control {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.GameInputEvent;
import flash.ui.GameInput;
import flash.ui.GameInputControl;
import flash.ui.GameInputDevice;

public class InputController extends EventDispatcher{
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
        for(var i:int = 0; i < myDevice.numControls; i++) {
            var c:GameInputControl = myDevice.getControlAt(i);//input reference (AXIS STICK, BUTTON, TRIGGER, etc) "0" is the 1st input
            c.addEventListener(Event.CHANGE, onChangeControl);
        }
    }

    private function onChangeControl(event:Event):void {
        var c:GameInputControl = event.target as GameInputControl;
        trace("id: " + c.id);//the name of this control. Ex: "AXIS_0"
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
