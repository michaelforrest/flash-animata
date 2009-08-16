package animata.models {

	/**
	 * @author michaelforrest
	 */
	public class AttachedVertex {
		private static var BONE_MINIMAL_WEIGHT : Number= 0.1;
		public var  vertex :Vertex;
		private var d : Number;
		private var w : Number;
		public var ca : Number;
		public var sa : Number;
		public var weight : Number;
		private var bone : Bone;
		public function AttachedVertex( element :XML,  bone : Bone, mesh : Mesh) {
			this.bone = bone;
			assignAttributes(element, mesh);
			setInitialConditions();
		}

		private function setInitialConditions() :void{
			var x0 : Number = bone.j0.x;
			var y0 : Number = bone.j0.y;
			var x1 : Number = bone.j1.x;
			var y1 : Number = bone.j1.y;

			var alpha : Number = Math.atan2(y1 - y0, x1 - x0);
			var dx : Number = (x1 - x0);
			var dy : Number = (y1 - y0);
//			float dCurrent = PApplet.sqrt(dx*dx + dy*dy);
			var x : Number = x0 + dx * 0.5;
			var y : Number = y0 + dy * 0.5;

			var vx : Number = vertex.x;
			var vy : Number = vertex.y;
			var vd : Number = Math.sqrt((x - vx) * (x - vx) + (y - vy) * (y - vy));

			var vdnorm : Number = vd / (bone.radius * bone.size * .5);

			if (vdnorm >= 1)
			{
				weight = BONE_MINIMAL_WEIGHT;
			}
			else
			{
				weight = Math.pow(1.0 - vdnorm, 1.0 / bone.falloff);
			}

			var a : Number = Math.atan2(vy - y, vx - x) - alpha;
			sa = vd * (Math.sin(a));
			ca = vd * (Math.cos(a));
		}

		private function assignAttributes( element : XML, mesh : Mesh) :void{
			vertex = mesh.vertices[element.@id];
			d = element.@d;
			w = element.@w;
			ca = element.@ca;
			sa = element.@sa;
		}
	}
}
