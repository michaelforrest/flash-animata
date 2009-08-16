package app.models {

	/**
	 * @author michaelforrest
	 */
	public class Face {
		public var vertices : Array = [];


		public function Face( element :XML, vertices :Array) {
			this.vertices[0] = vertices[element.@v0];
			this.vertices[1] = vertices[element.@v1];
			this.vertices[2] = vertices[element.@v2];
		}


	}
}
