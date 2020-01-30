package com.grantech.colleagues {
	public class CMath {
		static public var EPSILON : Number = 0.0001;
		static public var EPSILON_SQ : Number = 0;
		static public var PENETRATION_ALLOWANCE : Number = 0.01;
		static public var PENETRATION_CORRETION : Number = 0.4;
		static public function vector_normalizeX(x : Number,y : Number) : Number {
			var lenSq : Number = x * x + y * y;
			if(lenSq > com.grantech.colleagues.CMath.EPSILON_SQ) {
				var invLen : Number = 1.0 / Math.sqrt(lenSq);
				return x * invLen;
			};
			return x;
		}
		
		static public function vector_normalizeY(x : Number,y : Number) : Number {
			var lenSq : Number = x * x + y * y;
			if(lenSq > com.grantech.colleagues.CMath.EPSILON_SQ) {
				var invLen : Number = 1.0 / Math.sqrt(lenSq);
				return y * invLen;
			};
			return y;
		}
		
		static public function matrix_rotate(matrix : Array,radians : Number) : void {
			var c : Number = Math.cos(radians);
			var s : Number = Math.sin(radians);
			matrix[0] = c;
			matrix[1] = -s;
			matrix[2] = s;
			matrix[3] = c;
		}
		
		static public function matrix_abs(matrix : Array) : void {
			matrix[0] = Math.abs(matrix[0]);
			matrix[1] = Math.abs(matrix[1]);
			matrix[2] = Math.abs(matrix[2]);
			matrix[3] = Math.abs(matrix[3]);
		}
		
		static public function matrix_transpose(matrix : Array) : void {
			var m1 : Number = matrix[1];
			matrix[1] = matrix[2];
			matrix[2] = m1;
		}
		
		static public function matrix_transformX(matrix : Array,x : Number,y : Number) : Number {
			return matrix[0] * x + matrix[1] * y;
		}
		
		static public function matrix_transformY(matrix : Array,x : Number,y : Number) : Number {
			return matrix[2] * x + matrix[3] * y;
		}
		
		static static_init function init() : void{
			com.grantech.colleagues.CMath.EPSILON_SQ = com.grantech.colleagues.CMath.EPSILON * com.grantech.colleagues.CMath.EPSILON;
		}
	}
}
namespace static_init;
com.grantech.colleagues.CMath.static_init::init();
