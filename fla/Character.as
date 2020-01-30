package {
	import flash.display.MovieClip;

	public class Character extends MovieClip {
		public static var STATE_NAME_IDLE: String = "idle";
		public static var STATE_NAME_WALK: String = "walk";
		public static var STATE_NAME_CARRY: String = "carry";
		public static var STATE_NAME_PUNCH: String = "punch";
		public static var STATE_NAME_DIE: String = "die";
		public static var STATE_NAME_GET_HIT: String = "get_hit";
		public static var STATE_NAME_IDLE_CARRY: String = "idle_carry";
		
		public static var EVENT_END_HIT: String = "eventEndHit";

		public function Character() {
			// constructor code
		}
	}
}