package com.grantech.colleagues {
	import com.grantech.colleagues.Shape;
	public class Colleague {
		public function Colleague(shape : com.grantech.colleagues.Shape = null,x : int = 0,y : int = 0) : void {
			this.x = x;
			this.y = y;
			this.shape = shape;
			this.shape.colleague = this;
			this.shape.initialize();
		}
		
		public var x : Number = 0;
		public var y : Number = 0;
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
