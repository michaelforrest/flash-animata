package app.views {
	import app.models.Layer;

	import com.lbi.mvc.view.ViewBase;

	public class LayerView extends ViewBase {

	private var layer :Layer;
	private var mesh : MeshView ;
	private var layers : Array;

	public function LayerView(layer : Layer) {
		super({});
		this.layer = layer;
		alpha = layer.alpha;
		scaleX = scaleY = layer.scale;
		doTransformation();
		if(layer.mesh){
			 mesh = add( MeshView, layer) as MeshView;
		}
		addChildLayers(layer.layers);
		
	}

	private function addChildLayers(layers : Array) :void{
		this.layers = [];
		for (var i : int = 0; i < layers.length; i++) {
			var layer : Layer = layers[i];
			this.layers.push(add( LayerView, layer));
			
		}
	}

	public function draw() :void{
		if(!layer.visible || layer.alpha == 0) return;
		
		if(mesh) {
			mesh.draw();
		}
//		if(AnimataPlayback.debugging()) drawDebugStuff();
		drawChildLayers();

	}
//	private function drawDebugStuff() {
//		if(layer.skeleton == null) return;
//			for (var i : int = 0; i < layer.skeleton.joints.length; i++) {
//				var joint : Joint = layer.skeleton.joints[i];
//				applet.fill(0xFFFFFF00);
//				applet.ellipse(joint.x, joint.y, 20, 20);
//				
//			}
//		applet.stroke(0x99FF00FF);
//		applet.strokeWeight(5);
//		for (var i : int = 0; i < layer.skeleton.bones.length; i++) {
//			var bone : Bone = layer.skeleton.bones[i];
//			applet.line(bone.j1.x, bone.j1.y, bone.j0.x, bone.j0.y);
//		}
//	}

	private function drawChildLayers() :void{
		for (var i : int = 0; i < layers.length; i++) {
			var layerView : LayerView = layers[i];
			layerView.draw();
			
		}
	}


	// this is like the calcTransformationMatrix method from the original, but called during draw
	// TODO: do this once
	private function doTransformation() :void {
		x = layer.x;
		y = layer.y;
		z = layer.z;


	}

}
}
