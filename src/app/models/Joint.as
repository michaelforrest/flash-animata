package app.models {

	/**
	 * @author michaelforrest
	 */
	public class Joint {
		public var  x : Number;
		public var y : Number;
		public var fixed : Boolean;
		public var name : String;

		public function Joint( element : XML) {
			name = element.@name; // should default to ""
			x = element.@x;
			y = element.@y;
			fixed = element.@fixed == 1;
		}

		public function simulate() :void {
			if(!fixed){
				//y += AnimataPlayback.gravity;
			}
		}
	}
}
