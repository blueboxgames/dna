package com.grantech.colleagues {
	import com.grantech.colleagues.Contacts;
	import com.grantech.colleagues.Colleague;
	import com.grantech.colleagues.Shape;
	public class Colleagues2d {
		public function Colleagues2d(deltaTime : Number = NaN) : void {
			this.deltaTime = deltaTime;
			this.contacts = new Array();
			this.colleagues = new Array();
		}
		
		public var deltaTime : Number = 0;
		public var contacts : Array;
		public var colleagues : Array;
		public function step() : void {
			this.contacts = new Array();
			var len : int = this.colleagues.length;
			{
				var _g : int = 0;
				var _g1 : int = len;
				while(_g < _g1) {
					var i : int = _g++;
					var a : com.grantech.colleagues.Colleague = this.colleagues[i];
					{
						var _g2 : int = i + 1;
						var _g11 : int = len;
						while(_g2 < _g11) {
							var j : int = _g2++;
							var b : com.grantech.colleagues.Colleague = this.colleagues[j];
							if(a.invMass == 0 && b.invMass == 0) continue;
							var contact : com.grantech.colleagues.Contacts = this.contactsInstatiate(a,b);
							contact.solve();
							if(contact.count > 0) this.contacts.push(contact);
							else this.contactsDispose(contact);
						}
					}
				}
			};
			{
				var _g21 : int = 0;
				var _g3 : int = len;
				while(_g21 < _g3) {
					var i1 : int = _g21++;
					this.integrateVelocity(this.colleagues[i1],this.deltaTime);
				}
			};
			{
				var _g4 : int = 0;
				var _g5 : int = this.contacts.length;
				while(_g4 < _g5) {
					var i2 : int = _g4++;
					this.contacts[i2].positionalCorrection();
					this.contactsDispose(this.contacts[i2]);
				}
			}
		}
		
		public function add(shape : com.grantech.colleagues.Shape,x : int,y : int) : com.grantech.colleagues.Colleague {
			var c : com.grantech.colleagues.Colleague = new com.grantech.colleagues.Colleague(shape,x,y);
			this.colleagues.push(c);
			return c;
		}
		
		public function integrateVelocity(c : com.grantech.colleagues.Colleague,deltaTime : Number) : void {
			if(c.invMass == 0) return;
			c.x += c.speedX * deltaTime;
			c.y += c.speedY * deltaTime;
		}
		
		protected var pool : Array = new Array();
		protected var i : int = 0;
		public function contactsDispose(m : com.grantech.colleagues.Contacts) : void {
			this.pool[this.i++] = m;
		}
		
		public function contactsInstatiate(a : com.grantech.colleagues.Colleague,b : com.grantech.colleagues.Colleague) : com.grantech.colleagues.Contacts {
			if(this.i > 0) {
				this.i--;
				this.pool[this.i].a = a;
				this.pool[this.i].b = b;
				return this.pool[this.i];
			};
			return new com.grantech.colleagues.Contacts(a,b);
		}
	}
}
