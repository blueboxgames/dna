package control {
import flash.display.Sprite;

public class HeartGroup extends Sprite {
    private var _count:int;
    private var lastIndex:int = 0;

    public function get count():int {
        return _count;
    }

    public function set count(value:int):void {
        _count = value;
    }

    private var padding:int = 40;

    public function HeartGroup(count:int, isLTR:Boolean) {
        this.count = count;
        for (var i:int = 0; i < count; i++) {
            var heart:Heart = new Heart();
            heart.scaleX = heart.scaleY = 0.5;
            if (isLTR)
                heart.x += (i * padding);
            else
                heart.x -= (i * padding);
            this.addChild(heart);
        }
    }

    public function decrease():void {
        trace("decrease heart.");
        if (this.lastIndex < 0) {
            this.lastIndex++;
            return;
        }
        if (this.lastIndex > this.count - 1)
            return;
        var h:Heart = this.getChildAt(this.lastIndex) as Heart;
        h.isFull = false;
        this.lastIndex++;
    }

    public function reset():void {
        for (var i:int = 0; i < this.numChildren; i++) {
            var h:Heart = this.getChildAt(i) as Heart;
            h.isFull = true;
            this.lastIndex = -1;
        }
    }
}
}