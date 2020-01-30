package com.grantech.colleagues {
	import com.grantech.colleagues.CMath;
	import com.grantech.colleagues.Colleague;
	import com.grantech.colleagues.Collision;
	public class Contacts {
		public function Contacts(a : com.grantech.colleagues.Colleague = null,b : com.grantech.colleagues.Colleague = null) : void {
			this.a = a;
			this.b = b;
			this.points = [0,0,0,0];
			this.collision = new com.grantech.colleagues.Collision();
		}
		
		public var a : com.grantech.colleagues.Colleague;
		public var b : com.grantech.colleagues.Colleague;
		public var penetration : Number = 0;
		public var normalX : Number = 0;
		public var normalY : Number = 0;
		public var count : int;
		public var points : Array;
		public var collision : com.grantech.colleagues.Collision;
		public function solve() : void {
			this.collision.methods[this.a.shape.type][this.b.shape.type](this,this.a,this.b);
		}
		
		public function setPoint(index : int,x : Number,y : Number) : void {
			this.points[index * 2] = x;
			this.points[index * 2 + 1] = y;
		}
		
		public function getPointX(index : int) : Number {
			return this.points[index * 2];
		}
		
		public function getPointY(index : int) : Number {
			return this.points[index * 2 + 1];
		}
		
		public function positionalCorrection() : void {
			var correction : Number = Math.max(this.penetration - com.grantech.colleagues.CMath.PENETRATION_ALLOWANCE,0.0) / (this.a.invMass + this.b.invMass) * com.grantech.colleagues.CMath.PENETRATION_CORRETION;
			this.a.x += this.normalX * -this.a.invMass * correction;
			this.a.y += this.normalY * -this.a.invMass * correction;
			this.b.x += this.normalX * this.b.invMass * correction;
			this.b.y += this.normalY * this.b.invMass * correction;
		}
		
	}
}
