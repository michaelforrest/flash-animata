package app.models {

	/**
	 * @author michaelforrest
	 */
	public class Vertex {

		public var x :Number;
		public var y : Number;
		public  var u : Number;
		public var v : Number;
		public var selected :int;
		public function Vertex( element : XML) {
			x = element.@x;
			y = element.@y;
			u = element.@u;
			v = element.@v;
			selected = element.@selected;
		}
	}
}
