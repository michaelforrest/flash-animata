package animata.models {

	public class Layer {

		
		public var layers :Array = [];
		public var texture : Texture ;
		public var mesh : Mesh;
		public var  skeleton : Skeleton;
		public var  name : String = "root";
		public var  x : Number = 0;
		public var y : Number = 0;
		public var  z : Number = 0;
		public var  alpha : Number = 1;
		public var  scale : Number = 1;
		public var visible : Boolean = true;
		public var  rotation : Number = 0;
		public var  anchor : Joint;

		private static var allLayers  :Array = [];

		public function Layer(element : XML, library : Class) {
			setupAttributes(element);
			addChildLayersIfPresent(element, library);
			anchor = findAnchor();
			allLayers.push(this);
		}
		
		public function hasChanged() : Boolean {
			if(!skeleton) return false;
			return skeleton.hasChanged();
		}

		
		private function  addChildLayersIfPresent( element : XML,  library : Class) : void {
			var innerLayers : XMLList = element.layer;
			if(innerLayers.length() > 0) {
				addLayers(innerLayers, library);
			} else {
				setupLayerContents(element, library);
			}
		}

		private function setupAttributes(element : XML) : void {
			name = element.@name;
			x = element.@x;
			y = element.@y;
			z = -element.@z;
//			alpha = element.@alpha || 1;
			
			scale = element.@scale > 0 ? element.@scale : scale;
//			visible = element.@vis == 1;
		}

		private function  setupLayerContents(element : XML, library :Class ) : void {
			texture = new Texture(element.child("texture"), library);
			mesh = new Mesh(element.mesh);
			var skeletonElement : XMLList = element.skeleton;
			if(skeletonElement == null) return;
			skeleton = new Skeleton(skeletonElement, mesh);
		}

		public function  addLayers( children : XMLList,  library :Class) : void {
			for (var i : int = 0;i < children.length(); i++) {
				var element : XML = children[i];
				addLayer(library, element);
			}
		}

		public function addLayer( library : Class,  element : XML) : Layer {
			var layer : Layer = new Layer(element, library);
			layers.push(layer);
			return layer;
		}

		public function simulate() : void {
			if(!visible || alpha == 0) return;
			if(skeleton != null ) skeleton.simulate(40);
			for (var i : int = 0;i < layers.length; i++) {
				var layer : Layer = layers[i];
				layer.simulate();
			}
		}

		public static function  toggle(name : String) : void {
			for (var i : int = 0;i < allLayers.length; i++) {
				var layer : Layer = allLayers[i];
				if(layer.name != null && layer.name == name) layer.visible = !layer.visible;
			}
		}

		public static function  setVisibility( name : String,  visible : Boolean) : void {
			for (var i : int = 0;i < allLayers.length; i++) {
				var layer : Layer = allLayers[i];
				if(layer.name != null && layer.name == name) layer.visible = visible;
			}
		}

		public static function  setAlpha(name : String,  value : Number) : void {
			for (var i : int = 0;i < allLayers.length; i++) {
				var layer : Layer = allLayers[i];
				if(layer.name != null && layer.name == name) layer.alpha = value;
			}
		}

		
		
//		private function setRotation( value : Number) : void {
//			if(anchor == null) anchor = findAnchor();
//			rotation = value;
//		}

		private  function  findAnchor() : Joint {
			if(skeleton == null) return null;
			for (var i : int = 0;i < skeleton.joints.length; i++) {
				var joint : Joint = skeleton.joints[i];
				if(joint.name == name + "_anchor") {
					trace("anchor for layer:" + name + ".x=" + joint.x + ",y=" + joint.y);
					trace("layer position: " + x + "," + y);
					return joint;
				}
			}
			return null;
		}

		
//		private function setScale(value : Number) : void {
//			scale = value;
//		}

		public function  getAllBones( bones : Array) : void {
			for (var i : int = 0;i < layers.length; i++) {
				var layer : Layer = layers[i];
			
				layer.getAllBones(bones);
			}
			if(skeleton == null) return;
			bones.addAll(skeleton.bones);
		}

//		public static function setScale(scene : Scene,  name : String,  value : Number) : void {
//			for (var i : int = 0;i < scene.layers.length; i++) {
//				var layer : Layer = scene.layers[i];
//				if(layer.name != null && layer.name == name) layer.setScale(value);
//			}
//		}

		public function getAllLayers( result : Array) : void {
			for (var i : int = 0;i < layers.length; i++) {
				var layer : Layer = layers[i];
				layer.getAllLayers(result);
			}
			result.addAll(layers);
		}

//		public static function  setRotation( scene : Scene,  name : String,  value : Number) : void {
//			for (var i : int = 0;i < scene.layers.length; i++) {
//				var layer : Layer = scene.layers[i];
//				if(layer.name != null && layer.name == name) layer.setRotation(value);
//			}
//		}
	}
}
