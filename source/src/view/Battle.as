package view {
import flash.display.Sprite;

import utils.IState;

public class Battle extends Sprite implements IState{
    public var field:FieldView;

    public function Battle() {
        super();

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
