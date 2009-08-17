package animata.models {

	/**
	 * @author michaelforrest
	 */
	public class Face {
		private var v0 : Vertex;
		private var v1 : Vertex;
		private var v2 : Vertex;
		private var triangles : Vector.<Number>;
		private var uvCoordinates : Vector.<Number>;

		
		public function Face( element :XML, vertices :Array) {
			v0 = vertices[element.@v0];
			v1 = vertices[element.@v1];
			v2 = vertices[element.@v2];
			getTriangles();
			uvCoordinates = Vector.<Number>([ v0.u, v0.v,  v1.u, v1.v,  v2.u, v2.v]);
		}
		
		public function changed() : Boolean {
			if(v0.x != triangles[0]) return true;
			if(v0.y != triangles[1]) return true;
			if(v1.x != triangles[2]) return true;
			if(v1.y != triangles[3]) return true;
			if(v2.x != triangles[4]) return true;
			if(v2.y != triangles[5]) return true;
			return false;
		}

		public function getUVCoordinates() : Vector.<Number> {
			return uvCoordinates;
		}

		public function getTriangles() : Vector.<Number>{
			triangles = Vector.<Number>([v0.x, v0.y,  v1.x, v1.y,  v2.x, v2.y]);
			return triangles;	
		}
	}
}
