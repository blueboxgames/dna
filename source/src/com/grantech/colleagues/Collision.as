package com.grantech.colleagues {
	import com.grantech.colleagues.Contacts;
	import com.grantech.colleagues.CMath;
	import com.grantech.colleagues.Colleague;
	public class Collision {
		public function Collision() : void {
			this.methods = [[this.checkCC,this.checkCP],[this.checkPC,this.checkCC]];
		}
			
		public var contacts : com.grantech.colleagues.Contacts;
		public var normalX : Number = 0;
		public var normalY : Number = 0;
		public var distance : Number = 0;
		public var radiuses : Number = 0;
		public var methods : Array;
		public function check(contacts : com.grantech.colleagues.Contacts,a : com.grantech.colleagues.Colleague,b : com.grantech.colleagues.Colleague) : Boolean {
			this.contacts = contacts;
			this.normalX = b.x - a.x;
			this.normalY = b.y - a.y;
			this.distance = Math.sqrt(this.normalX * this.normalX + this.normalY * this.normalY);
			this.radiuses = a.shape.radius + b.shape.radius;
			if(this.distance > this.radiuses) {
				this.contacts.count = 0;
				return false;
			};
			return true;
		}
		
		public function checkCC(contacts : com.grantech.colleagues.Contacts,a : com.grantech.colleagues.Colleague,b : com.grantech.colleagues.Colleague) : Boolean {
			if(!this.check(contacts,a,b)) return false;
			contacts.count = 1;
			if(this.distance == 0.0) {
				contacts.penetration = a.shape.radius;
				contacts.normalX = 1;
				contacts.normalY = 0;
				contacts.setPoint(0,a.x,a.y);
			}
			else {
				contacts.penetration = this.radiuses - this.distance;
				contacts.normalX = this.normalX / this.distance;
				contacts.normalY = this.normalY / this.distance;
				contacts.setPoint(0,contacts.normalX * a.shape.radius + a.x,contacts.normalY * a.shape.radius + a.y);
			};
			return true;
		}
		
		public function checkPC(contacts : com.grantech.colleagues.Contacts,a : com.grantech.colleagues.Colleague,b : com.grantech.colleagues.Colleague) : Boolean {
			if(!this.checkCP(contacts,b,a)) return false;
			if(contacts.count > 0) {
				contacts.normalX *= -1;
				contacts.normalY *= -1;
			};
			return true;
		}
		
		public function checkCP(contacts : com.grantech.colleagues.Contacts,a : com.grantech.colleagues.Colleague,b : com.grantech.colleagues.Colleague) : Boolean {
			if(!this.check(contacts,a,b)) return false;
			contacts.count = 0;
			com.grantech.colleagues.CMath.matrix_transpose(b.shape.matrix);
			var centerX : Number = com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,a.x - b.x,a.y - b.y);
			var centerY : Number = com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,a.x - b.x,a.y - b.y);
			com.grantech.colleagues.CMath.matrix_transpose(b.shape.matrix);
			var separation : Number = -10000000//Math["NEGATIVE_INFINITY"];
			var faceNormal : int = 0;
			{
				var _g : int = 0;
				var _g1 : int = b.shape.vertexCount;
				while(_g < _g1) {
					var i : int = _g++;
					var cxsb : Number = centerX - b.shape.getX(i);
					var cysb : Number = centerY - b.shape.getY(i);
					var s : Number = b.shape.getNormalX(i) * cxsb + b.shape.getNormalY(i) * cysb;
					if(s > a.shape.radius) return true;
					if(s > separation) {
						separation = s;
						faceNormal = i;
					}
				}
			};
			var v1x : Number = b.shape.getX(faceNormal);
			var v1y : Number = b.shape.getY(faceNormal);
			var i2 : int = ((faceNormal + 1 < b.shape.vertexCount)?faceNormal + 1:0);
			var v2x : Number = b.shape.getX(i2);
			var v2y : Number = b.shape.getY(i2);
			if(separation < com.grantech.colleagues.CMath.EPSILON) {
				contacts.count = 1;
				contacts.normalX = -com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,b.shape.getNormalX(faceNormal),b.shape.getNormalY(faceNormal));
				contacts.normalY = -com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,b.shape.getNormalX(faceNormal),b.shape.getNormalY(faceNormal));
				contacts.setPoint(0,contacts.normalX * a.shape.radius + a.x,contacts.normalY * a.shape.radius + a.y);
				contacts.penetration = a.shape.radius;
				return true;
			};
			var dot1 : Number = (centerX - v1x) * (v2x - v1x) + (centerY - v1y) * (v2y - v1y);
			var dot2 : Number = (centerX - v2x) * (v1x - v2x) + (centerY - v2y) * (v1y - v2y);
			contacts.penetration = a.shape.radius - separation;
			if(dot1 <= 0.0) {
				if((centerX - v1x) * (centerX - v1x) + (centerY - v1y) * (centerY - v1y) > a.shape.radius * a.shape.radius) return true;
				contacts.count = 1;
				contacts.normalX = v1x - centerX;
				contacts.normalY = v1y - centerY;
				contacts.normalX = com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,contacts.normalX,contacts.normalY);
				contacts.normalY = com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,contacts.normalX,contacts.normalY);
				contacts.normalX = com.grantech.colleagues.CMath.vector_normalizeX(contacts.normalX,contacts.normalY);
				contacts.normalY = com.grantech.colleagues.CMath.vector_normalizeY(contacts.normalX,contacts.normalY);
				contacts.setPoint(0,com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,v1x,v1y) + b.x,com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,v1x,v1y) + b.y);
			}
			else if(dot2 <= 0.0) {
				if((centerX - v2x) * (centerX - v2x) + (centerY - v2y) * (centerY - v2y) > a.shape.radius * a.shape.radius) return true;
				contacts.count = 1;
				contacts.normalX = v2x - centerX;
				contacts.normalY = v2y - centerY;
				contacts.normalX = com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,contacts.normalX,contacts.normalY);
				contacts.normalY = com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,contacts.normalX,contacts.normalY);
				contacts.normalX = com.grantech.colleagues.CMath.vector_normalizeX(contacts.normalX,contacts.normalY);
				contacts.normalY = com.grantech.colleagues.CMath.vector_normalizeY(contacts.normalX,contacts.normalY);
				contacts.setPoint(0,com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,v2x,v2y) + b.x,com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,v2x,v2y) + b.y);
			}
			else {
				var nx : Number = b.shape.getNormalX(faceNormal);
				var ny : Number = b.shape.getNormalY(faceNormal);
				var csv1x : Number = centerX - v1x;
				var csv1y : Number = centerY - v1y;
				var dotcsv1 : Number = csv1x * nx + csv1y * ny;
				if(dotcsv1 > a.shape.radius) return true;
				contacts.count = 1;
				contacts.normalX = -com.grantech.colleagues.CMath.matrix_transformX(b.shape.matrix,nx,ny);
				contacts.normalY = -com.grantech.colleagues.CMath.matrix_transformY(b.shape.matrix,nx,ny);
				contacts.setPoint(0,a.x + contacts.normalX * a.shape.radius,a.y + contacts.normalY * a.shape.radius);
			};
			return true;
		}
		
	}
}
