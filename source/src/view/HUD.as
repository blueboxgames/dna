package view {
import control.HeartGroup;

import flash.display.Sprite;

import model.Player;

public class HUD extends Sprite {
    private var healthGroup1:HeartGroup;
    private var healthGroup2:HeartGroup;

    public function HUD() {
        this.healthGroup1 = new HeartGroup(Player.START_HEALTH, true);
        healthGroup1.x = 0;
        this.healthGroup2 = new HeartGroup(Player.START_HEALTH, false);
        healthGroup2.x = 800 - 30;

        this.addChild(healthGroup1);
        this.addChild(healthGroup2);
    }

    public function updateHealth(value:int, id:int):void {
        if(id == 0) {
            healthGroup1.decrease();
        }
        if(id == 1) {
            healthGroup2.decrease();
        }
    }

    public function resetHealth(value:int, id:int):void {
        if(id == 0) {
            healthGroup1.reset();
        }
        if(id == 1) {
            healthGroup2.reset();
        }
    }
}
}
