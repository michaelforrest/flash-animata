package app.views {
	import app.models.Bone;
	import app.models.Joint;
	import app.models.Layer;

	import com.lbi.mvc.view.ViewBase;

	public class LayerView extends ViewBase {

	private var layer :Layer;
	private var mesh : MeshView ;
	private var layers : Array;

	public function LayerView(layer : Layer) {
		super({});
		this.layer = layer;
		if(layer.mesh != null) mesh = new MeshView(layer);
		addChildLayers(layer.layers);
	}

	private function addChildLayers(layers : Array) {
		this.layers = new ArrayList<LayerView>();
		for (layer : Layer : layers) {
			this.layers.add(new LayerView(layer, applet));
		}
	}

	public function draw() {
		if(!layer.visible || layer.alpha == 0) return;
		if(layer.alpha != 1) applet.tint(layer.alpha * 255);
		applet.pushMatrix();
		doTransformation();
		applet.pushMatrix();

		if(layer.anchor != null){
			applet.translate(layer.anchor.x, layer.anchor.y);
			applet.rotate(-layer.rotation);
			applet.scale(layer.scale,layer.scale,1);
			applet.translate(-layer.anchor.x, -layer.anchor.y);
		}


		if(mesh!= null) mesh.draw();
		if(AnimataPlayback.debugging()) drawDebugStuff();
		drawChildLayers();

		applet.popMatrix();

		applet.popMatrix();
		if(layer.alpha != 1) applet.tint(255);
	}
	private function drawDebugStuff() {
		if(layer.skeleton == null) return;
			for (var i : int = 0; i < layer.skeleton.joints.length; i++) {
				var joint : Joint = layer.skeleton.joints[i];
				applet.fill(0xFFFFFF00);
				applet.ellipse(joint.x, joint.y, 20, 20);
				
			}
		applet.stroke(0x99FF00FF);
		applet.strokeWeight(5);
		for (var i : int = 0; i < layer.skeleton.bones.length; i++) {
			var bone : Bone = layer.skeleton.bones[i];
			applet.line(bone.j1.x, bone.j1.y, bone.j0.x, bone.j0.y);
		}
	}

	private function drawChildLayers() {
		for (var i : int = 0; i < layers.length; i++) {
			var layerView : LayerView = layers[i];
			layerView.draw();
			
		}
	}


	// this is like the calcTransformationMatrix method from the original, but called during draw
	private function doTransformation() {
		applet.translate(layer.x, layer.y,layer.z);


	}

}
}
