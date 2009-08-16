package app.views {
	import app.models.Scene;

	import animata.views.LayerView;

	import app.helpers.events.SceneEvent;

	import com.lbi.mvc.view.ViewBase;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class SceneView extends ViewBase {
		private var scene : Scene;
		private var rootView : LayerView;

		public function SceneView(options : Object) {
			super({});
			scene = options.scene;
			scene.registerEvents(this, [SceneEvent.READY]);
		}
		public function onReady( e : Event ) : void{
			x = 500;
			y = 500;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			rootView = add(LayerView, scene.root) as LayerView;
		}
		
		private function onEnterFrame(event : Event) : void {
			scene.simulate();
			rootView.draw();	
		} 
	}
}
