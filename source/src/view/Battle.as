package view {
import flash.display.Sprite;
import flash.events.Event;

import utils.IState;

public class Battle extends Sprite implements IState{
    public var field:FieldView;

    public function Battle() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        this.field = new FieldView();
        this.field.addRepairable(50, 50);
        this.field.addRepairable(100, 100);
        this.stage.addChild(this.field);
        this.field.initialize();
    }

    public function destroy():void {
    }
}
}
