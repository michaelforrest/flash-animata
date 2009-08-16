package app.views {
	import app.helpers.events.SceneEvent;
	import app.models.Scene;

	import com.lbi.mvc.view.ViewBase;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class SceneView extends ViewBase {
		private var scene : Scene;
		
		public function SceneView(options : Object) {
			super({});
			scene = options.scene;
			scene.registerEvents(this, [SceneEvent.READY]);
		}
		public function onReady( e : Event ) : void{
			text("the scene loaded!");
		} 
	}
}
