package app.models {

	/**
	 * @author michaelforrest
	 */
	public class Face {
		private var v0 : Vertex;
		private var v1 : Vertex;
		private var v2 : Vertex;

		
		public function Face( element :XML, vertices :Array) {
			v0 = vertices[element.@v0];
			v1 = vertices[element.@v1];
			v2 = vertices[element.@v2];
		}
		
		public function getUVCoordinates() : Vector.<Number> {
			return Vector.<Number>([ v0.u, v0.v,  v1.u, v1.v,  v2.u, v2.v]);
		}

		public function getTriangles() : Vector.<Number>{
			return Vector.<Number>([v0.x, v0.y,  v1.x, v1.y,  v2.x, v2.y]);	
		}
	}
}
