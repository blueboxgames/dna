package com.grantech.colleagues {
	import com.grantech.colleagues.Shape;
	import flash.events.EventDispatcher;
	public class Colleague extends EventDispatcher {
		public function Colleague(shape : com.grantech.colleagues.Shape = null,x : int = 0,y : int = 0) : void {
			this.x = x;
			this.y = y;
			this.shape = shape;
			this.shape.colleague = this;
			this.shape.initialize();
		}
		
    private var _x:Number = 0;
    public function get x():Number {
        return _x;
    }
    public function set x(value:Number):void {
        _x = value;
    }

    private var _y:Number = 0;
    public function get y():Number {
        return _y;
    }
    public function set y(value:Number):void {
        _y = value;
    }

		public var mass : Number = 0;
		public var invMass : Number = 0;
		public var shape : com.grantech.colleagues.Shape;
		public var side : int;
		public var speed : Number = 0;
		public var speedX : Number = 0;
		public var speedY : Number = 0;
		public function setStatic() : void {
			this.mass = 0.0;
			this.invMass = 0.0;
		}
	}
}
