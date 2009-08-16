package app.models {

	/**
	 * @author michaelforrest
	 */
	public class Bone {
		public var j0 : Joint;
		public var j1 : Joint;
		private var scale : Number;
		private  var maxScale : Number;
		private  var minScale : Number;
		public var tempo : Number;
		private var time : Number;
		private var attachedVertices : Array;
		public var name : String;
		private var stiffness : Number;
		public var size : Number;
		public var radius : Number;
		public var falloff : Number;
		private var mesh : Mesh;

		public function Bone( element : XML, joints : Array, mesh : Mesh) {
			this.mesh = mesh;
			assignAttributes(element ,joints);
			setInitialConditions();
			if(element.getChild("attached") != null) {
				addVertices(element.getChildren("attached/vertex"));
			}
		}

		private function setInitialConditions() {
			falloff = 1.0f;
		}

		private function assignAttributes( element : XML, joints : Array) {
			name = element.getStringAttribute("name", "");
			j0 = joints[element.getIntAttribute("j0")];
			j1 = joints[element.getIntAttribute("j1")];
			stiffness = element.getFloatAttribute("stiffness");
			scale = element.getFloatAttribute("lm");
			maxScale = element.getFloatAttribute("lmmax");
			minScale = element.getFloatAttribute("lmmin");
			tempo = element.getFloatAttribute("tempo");
			time = element.getFloatAttribute("time");
			size = element.getFloatAttribute("size");
			radius = element.getFloatAttribute("radius");
		}

		private function addVertices(children : Array) {
			attachedVertices = new AttachedVertex[children.length];
			for (var i : int = 0;i < children.length; i++) {
				var element : XML = children[i];
				var attachedVertex : AttachedVertex = new AttachedVertex(element, this,mesh);
				attachedVertices[i] = attachedVertex;
			}
		}

		public function simulate() {
			if (tempo > 0) {
				time += tempo / Animata.timeDivision;	// FIXME
				animateScale(0.5f + Math.sin(time) * 0.5f);
			}
			var dx : Number = (j1.x - j0.x);
			var dy : Number = (j1.y - j0.y);
			var dCurrent : Number = Math.sqrt(dx * dx + dy * dy);

			dx /= dCurrent;
			dy /= dCurrent;


			var m : Number = ((size * scale) - dCurrent) * stiffness;

			if (!j0.fixed ) {
				j0.x -= m * dx;
				j0.y -= m * dy;
			}

			if (!j1.fixed ) {
				j1.x += m * dx;
				j1.y += m * dy;
			}
		}

		private function animateScale( t : Number) {
			scale = minScale + ((maxScale - minScale) * t);
		}

		public function translateVertices() {
			var x0 : Number = j0.x;
			var y0 : Number = j0.y;
			var x1 : Number = j1.x;
			var y1 : Number = j1.y;

			var dx : Number = (x1 - x0);
			var dy : Number = (y1 - y0);

			var x : Number = x0 + dx * 0.5f;
			var y : Number = y0 + dy * 0.5f;

			var dCurrent : Number = Math.sqrt(dx * dx + dy * dy);
			//			if (dCurrent < FLT_EPSILON)
			//			{
			//				dCurrent = FLT_EPSILON;
			//			}
			dx /= dCurrent;
			dy /= dCurrent;

			if(attachedVertices == null) return;
			for (var i : int = 0;i < attachedVertices.length; i++) {
				var v : AttachedVertex = attachedVertices[i];
				var vx : Number = v.vertex.x;
				var vy : Number = v.vertex.y;
				var tx : Number = x + (dx * v.ca - dy * v.sa);
				var ty : Number = y + (dx * v.sa + dy * v.ca);
				vx += (tx - vx) * v.weight;
				vy += (ty - vy) * v.weight;
				v.vertex.x = vx;
				v.vertex.y = vy;
			}
		}

		public function setTempo( value : Number) {
			tempo = value;
		}

		public function setScale( value : Number) {
			setTempo(0);
			value = Math.max(0,value);
			value = Math.min(1,value);
			animateScale(value);
		}
	}
}
