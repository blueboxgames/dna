package control {
import com.alexomara.ane.AIRControl.AIRControl;
import com.alexomara.ane.AIRControl.events.AIRControlControllerEvent;
import com.alexomara.ane.AIRControl.events.AIRControlEvent;

import flash.events.EventDispatcher;

import utils.MyEvent;

public class InputController extends EventDispatcher {
    public static const MOVE_RIGHT:String = "moveRight";
    public static const MOVE_LEFT:String = "moveLeft";
    public static const MOVE_UP:String = "moveUp";
    public static const MOVE_DOWN:String = "moveDown";
    public static const PICK_DROP:String = "pickDrop";
    public static const HIT:String = "hit";

    public function InputController() {
        //Add the event listeners to detect controller attachment.
        AIRControl.addEventListener(AIRControlEvent.CONTROLLER_ATTACH, controllerAttach);
        AIRControl.addEventListener(AIRControlEvent.CONTROLLER_DETACH, controllerAttach);
    }

    private function controllerAttach(e:AIRControlEvent):void {
        //Fired on controller attach and detach.
        trace(e.type);
        var output:String;
        switch (e.type) {
            case AIRControlEvent.CONTROLLER_ATTACH:
                //Add event listeners for controller state changes.
                e.controller.addEventListener(AIRControlControllerEvent.AXIS_CHANGE, controllerEvent);
                e.controller.addEventListener(AIRControlControllerEvent.BUTTON_CHANGE, controllerEvent);
                e.controller.addEventListener(AIRControlControllerEvent.POV_CHANGE, controllerEvent);
                //Log the attach and a few key variables.
                output = "AIRControlEvent.CONTROLLER_ATTACH, controllerIndex=" + e.controllerIndex + ", controller.ID=" + e.controller.ID + ", controller.name=\"" + e.controller.name + "\"";
                //trace(output);
                break;
            case AIRControlEvent.CONTROLLER_DETACH:
                //Remove the event listeners.
                e.controller.removeEventListener(AIRControlControllerEvent.AXIS_CHANGE, controllerEvent);
                e.controller.removeEventListener(AIRControlControllerEvent.BUTTON_CHANGE, controllerEvent);
                e.controller.removeEventListener(AIRControlControllerEvent.POV_CHANGE, controllerEvent);
                //Log the detach and a few key variables.
                output = "AIRControlEvent.CONTROLLER_DETACH, controllerIndex=" + e.controllerIndex + ", controller.ID=" + e.controller.ID + ", controller.name=\"" + e.controller.name + "\"";
                //trace(output);
                break;
        }
    }

    private function controllerEvent(e:AIRControlControllerEvent):void {
        //Log information about what controller fired the event.
        var output:String;
        switch (e.type) {
            case AIRControlControllerEvent.AXIS_CHANGE:
                output = "AIRControlControllerEvent.AXIS_CHANGE, controller.ID=" + e.controller.ID + ", controller.name=\"" + e.controller.name + "\", elementIndex=" + e.elementIndex + "\", element.position=" + e.element["position"];
                if (e.elementIndex == 0) {
                    if (e.element["position"] > 0.01) {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {
                            action: MOVE_RIGHT,
                            id: e.controller.ID
                        }));
                    } else if (e.element["position"] < -0.01) {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {
                            action: MOVE_LEFT,
                            id: e.controller.ID
                        }));
                    } else {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: MOVE_RIGHT, id: e.controller.ID}));
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: MOVE_LEFT, id: e.controller.ID}));
                    }
                } else if (e.elementIndex == 1) {
                    if (e.element["position"] > 0.01) {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {
                            action: MOVE_DOWN,
                            id: e.controller.ID
                        }));
                    } else if (e.element["position"] < -0.01) {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {action: MOVE_UP, id: e.controller.ID}));
                    } else {
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: MOVE_DOWN, id: e.controller.ID}));
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: MOVE_UP, id: e.controller.ID}));
                    }
                }
                //trace(output);
                break;
            case AIRControlControllerEvent.POV_CHANGE:
                output = "AIRControlControllerEvent.POV_CHANGE, controller.ID=" + e.controller.ID + ", controller.name=\"" + e.controller.name + "\", elementIndex=" + e.elementIndex + "\", element.X=" + e.element["X"] + ", element.Y=" + e.element["Y"];
                //trace(output);
                break;
            case AIRControlControllerEvent.BUTTON_CHANGE:
                output = "AIRControlControllerEvent.BUTTON_CHANGE, controller.ID=" + e.controller.ID + ", controller.name=\"" + e.controller.name + "\", elementIndex=" + e.elementIndex + "\", element.down=" + e.element["down"];
                if (e.element["down"]) {
                    if (e.elementIndex == 3)
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {action: HIT, id: e.controller.ID}));
                    if (e.elementIndex == 2)
                        dispatchEvent(new MyEvent(MyEvent.INPUT_START, false, {
                            action: PICK_DROP,
                            id: e.controller.ID
                        }));
                } else {
                    if (e.elementIndex == 3)
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: HIT, id: e.controller.ID}));
                    if (e.elementIndex == 2)
                        dispatchEvent(new MyEvent(MyEvent.INPUT_END, false, {action: PICK_DROP, id: e.controller.ID}));
                }
                //trace(output);
                break;
        }
    }
}
}
