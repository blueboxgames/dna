package com.grantech.colleagues {
	import com.grantech.colleagues.CMath;
	import com.grantech.colleagues.Colleague;
	public class Shape {
		public function Shape(type : int = 0,radius : Number = NaN) : void {
			this.type = type;
			this.radius = radius;
			this.normals = new Array();
			this.vertices = new Array();
			this.matrix = [0.0,0.0,0.0,0.0];
		}
		
		public var type : int = 0;
		public var radius : Number = 0;
		public var vertexCount : int = 0;
		public var colleague : com.grantech.colleagues.Colleague;
		public var matrix : Array;
		public var normals : Array;
		public var vertices : Array;
		public function initialize() : void {
			this.computeMass(1.0);
		}
		
		public function computeMass(density : Number) : void {
			if(this.type == com.grantech.colleagues.Shape.TYPE_CIRCLE) {
				this.colleague.mass = Math.PI * this.radius * this.radius * density;
				this.colleague.invMass = ((this.colleague.mass != 0.0)?1.0 / this.colleague.mass:0.0);
				return;
			};
			var cx : Number = 0;
			var cy : Number = 0;
			var area : Number = 0.0;
			var I : Number = 0.0;
			var k_inv3 : Number = 0.33333333333333331;
			{
				var _g : int = 0;
				var _g1 : int = this.vertexCount;
				while(_g < _g1) {
					var i : int = _g++;
					var px1 : Number = this.getX(i);
					var py1 : Number = this.getY(i);
					var px2 : Number = this.getX((i + 1) % this.vertexCount);
					var py2 : Number = this.getY((i + 1) % this.vertexCount);
					var D : Number = px1 * py2 - py1 * px2;
					var triangleArea : Number = 0.5 * D;
					area += triangleArea;
					var weight : Number = triangleArea * k_inv3;
					cx += px1 * weight;
					cy += py1 * weight;
					cx += px2 * weight;
					cy += py2 * weight;
					var intx2 : Number = px1 * px1 + px2 * px1 + px2 * px2;
					var inty2 : Number = py1 * py1 + py2 * py1 + py2 * py2;
					I += 0.25 * k_inv3 * D * (intx2 + inty2);
				}
			};
			cx *= 1.0 / area;
			cy *= 1.0 / area;
			{
				var _g2 : int = 0;
				var _g3 : int = this.vertexCount;
				while(_g2 < _g3) {
					var i1 : int = _g2++;
					this.set(i1,this.getX(i1) - cx,this.getY(i1) - cy);
				}
			};
			this.colleague.mass = density * area;
			this.colleague.invMass = ((this.colleague.mass != 0.0)?1.0 / this.colleague.mass:0.0);
			com.grantech.colleagues.CMath.matrix_rotate(this.matrix,0);
		}
		
		public function set(index : int,x : Number,y : Number) : void {
			this.vertices[index * 2] = x;
			this.vertices[index * 2 + 1] = y;
		}
		
		protected function setX(index : int,value : Number) : Number {
			return this.vertices[index * 2] = value;
		}
		
		protected function setY(index : int,value : Number) : Number {
			return this.vertices[index * 2 + 1] = value;
		}
		
		public function getX(index : int) : Number {
			return this.vertices[index * 2];
		}
		
		public function getY(index : int) : Number {
			return this.vertices[index * 2 + 1];
		}
		
		public function setNormal(index : int,x : Number,y : Number) : void {
			this.normals[index * 2] = x;
			this.normals[index * 2 + 1] = y;
		}
		
		protected function setNormalX(index : int,x : Number) : Number {
			return this.normals[index * 2] = x;
		}
		
		protected function setNormalY(index : int,y : Number) : Number {
			return this.normals[index * 2 + 1] = y;
		}
		
		public function getNormalX(index : int) : Number {
			return this.normals[index * 2];
		}
		
		public function getNormalY(index : int) : Number {
			return this.normals[index * 2 + 1];
		}
		
		static public var TYPE_CIRCLE : int = 0;
		static public var TYPE_POLY : int = 1;
		static public function create_circle(radius : Number) : com.grantech.colleagues.Shape {
			return new com.grantech.colleagues.Shape(com.grantech.colleagues.Shape.TYPE_CIRCLE,radius);
		}
		
		static public function create_box(hw : Number,hh : Number) : com.grantech.colleagues.Shape {
			var shape : com.grantech.colleagues.Shape = new com.grantech.colleagues.Shape(com.grantech.colleagues.Shape.TYPE_POLY,Math.max(hw,hh));
			shape.vertexCount = 4;
			shape.set(0,-hw,-hh);
			shape.set(1,hw,-hh);
			shape.set(2,hw,hh);
			shape.set(3,-hw,hh);
			shape.setNormal(0,0.0,-1.0);
			shape.setNormal(1,1.0,0.0);
			shape.setNormal(2,0.0,1.0);
			shape.setNormal(3,-1.0,0.0);
			return shape;
		}
		
	}
}
