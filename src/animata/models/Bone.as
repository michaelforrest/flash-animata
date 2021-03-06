package animata.models {
	import com.lbi.animation.animator.Animator;

	/**
	 * @author michaelforrest
	 */
	public class Bone {
		
		public var j0 : Joint;
		public var j1 : Joint;
		private var __scale: Number = 1;
		public function get scale():Number{
			return __scale;
		}
		public function set scale(v : Number):void{
			changed = (__scale != v);
			__scale = v;
		}
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
		public static var allBones : Array = [];
		public var animator : Animator;
		private var changed : Boolean = true;

		public function Bone( element : XML, joints : Array, mesh : Mesh) {
			this.mesh = mesh;
			assignAttributes(element ,joints);
			tempo = 0;
			setInitialConditions();
			if(element.attached != null) {
				addVertices(element.attached.vertex);
			}
			animator = new Animator(this);
			allBones.push(this);
		}
		
		public function hasChanged() : Boolean {
			if(tempo > 0) return true;
			if(changed){
				changed = false;
				return true;
			}
			return false;
		}

		public function animateToTempo(v : Number) : void {
			animator.tempo = v;
		}

		public function animateToScale(v : Number) : void {
			animator.scale = v;
		}

		private function setInitialConditions() : void{
			falloff = 1.0;
		}

		private function assignAttributes( element : XML, joints : Array)  : void{
			name = element.@name;
			j0 = joints[element.@j0];
			j1 = joints[element.@j1];
			stiffness = element.@stiffness;
			scale = element.@lm;
			maxScale = element.@lmmax;
			minScale = element.@lmmin;
			tempo = element.@tempo;
			time = element.@time;
			size = element.@size;
			radius = element.@radius;
		}

		private function addVertices(children : XMLList) :void{
			attachedVertices = [];
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
				var attachedVertex : AttachedVertex = new AttachedVertex(element, this,mesh);
				attachedVertices.push( attachedVertex);
			}
		}

		public function simulate() : void{
			if (tempo > 0) {
				time += tempo / Animata.timeDivision;	// FIXME
				animateScale(0.5 + Math.sin(time) * 0.5);
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

		private function animateScale( t : Number):void {
			scale = minScale + ((maxScale - minScale) * t);
		}

		public function translateVertices() :void{
			var x0 : Number = j0.x;
			var y0 : Number = j0.y;
			var x1 : Number = j1.x;
			var y1 : Number = j1.y;

			var dx : Number = (x1 - x0);
			var dy : Number = (y1 - y0);

			var x : Number = x0 + dx * 0.5;
			var y : Number = y0 + dy * 0.5;

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

		public function setTempo( value : Number) :void{
			tempo = value;
		}

		public function setScale( value : Number) :void{
			setTempo(0);
			value = Math.max(0,value);
			value = Math.min(1,value);
			animateScale(value);
		}
	}
}
