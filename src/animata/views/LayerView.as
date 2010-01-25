package animata.views {
	import animata.models.Face;
	import animata.models.Layer;

	import app.controllers.App;
	import app.helpers.events.SceneEvent;

	import com.lbi.mvc.view.ViewBase;

	import flash.events.Event;

	public class LayerView extends ViewBase {

		private var layer : Layer;
		private var layers : Array;
		private var firstTime : Boolean = true;

		public function LayerView(layer : Layer) {
			super({});
			this.layer = layer;
			//		alpha = layer.alpha;
			App.getInstance().registerEvents(this, [SceneEvent.MODE_CHANGED]);
			scaleX = scaleY = layer.scale;
			doTransformation();
			addChildLayers(layer.layers);
		}
		public function onModeChanged( e : Event ) : void{
			firstTime = true;
		} 

		private function addChildLayers(layers : Array) : void {
			this.layers = [];
			for (var i : int = 0;i < layers.length; i++) {
				var layer : Layer = layers[i];
				this.layers.push(add(LayerView, layer));
			}
		}

		public function draw() : void {
			if(!layer.visible || layer.alpha == 0) return;
			if(layer.mesh) drawMesh();
		//	if(App.renderMode == App.WIREFRAME) drawDebugStuff();
			drawChildLayers();
		}

		public function drawMesh() : void {
			if( (App.renderMode == App.CHANGING)) graphics.clear();
			if(firstTime || layer.hasChanged()) {
				graphics.clear();
				drawFaces(layer.mesh.faces);
				firstTime = false;
			}
		}

		private function drawFaces(faces : Array) : void {
			if(App.renderMode != App.WIREFRAME) {
				graphics.lineStyle(0, 0, 0); 
				graphics.beginBitmapFill(layer.texture.getImage());
			} else {
				graphics.lineStyle(0, 0x466847);
			}
			
			for (var i : int = 0;i < faces.length; i++) {
				var face : Face = faces[i];
				drawFace(face);
			}
		}

		private function drawFace(face : Face) : void {
			if(App.renderMode == App.CHANGING && !face.changed()) return;		
			graphics.drawTriangles(face.getTriangles(), null, face.getUVCoordinates());
//			graphics.lineStyle(1, 0xFF0000);
//			graphics.drawTriangles(face.getTriangles());//,null,face.getUVCoordinates());
		}

		private function drawDebugStuff() {
		
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
		}

		private function drawChildLayers() : void {
			for (var i : int = 0;i < layers.length; i++) {
				var layerView : LayerView = layers[i];
				layerView.draw();
			}
		}

		
		// this is like the calcTransformationMatrix method from the original, but called during draw
		// TODO: do this once
		private function doTransformation() : void {
			x = layer.x;
			y = layer.y;
			z = layer.z;
		}
	}
}
