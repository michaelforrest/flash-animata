package app.models {

	public class Mesh {
	

	public var  vertices :Array= [];
	public var  faces : Array= [];

	public function Mesh( child : XML) {
		addVertices(child.getChildren("vertices/vertex"));
		addFaces(child.getChildren("faces/face"));
	}

	private function addVertices(children : Array) : void {
		vertices = [];
		for (var i : int = 0; i < children.length; i++) {
			var element : XML = children[i];
			var vertex :Vertex = new Vertex(element);
			vertices.push(vertex);
		}
	}

	private function addFaces(children : Array) : void {
		faces = new Face[children.length];
		for (var i : int = 0; i < children.length; i++) {
			var element : XML = children[i];
			var face :Face = new Face(element, vertices);
			faces.push(face);
			
		}
	}


}
}