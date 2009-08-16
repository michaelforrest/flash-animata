package animata.models {

	public class Mesh {

		
		public var  vertices : Array = [];
		public var  faces : Array = [];

		public function Mesh( child : XMLList) {
			addVertices(child.vertices.vertex);
			addFaces(child.faces.face);
		}

		private function addVertices(children : XMLList) : void {
			trace("adding ", children.length(),"vertices");
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
				var vertex : Vertex = new Vertex(element);
				vertices.push(vertex);
			}
		}

		private function addFaces(children : XMLList) : void {
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
				var face : Face = new Face(element, vertices);
				faces.push(face);
			}
		}
	}
}