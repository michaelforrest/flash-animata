package app.views {
	import com.lbi.debug.FPSView;
	import app.controllers.App;
	import app.controllers.KeyboardController;

	import com.lbi.mvc.view.ViewBase;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	[Frame(factoryClass="app.views.PreloaderView")]
	public class AppView extends ViewBase {
		private var application : App;
		
		public function AppView() {
			super({columnWidth:800});
			trace("Flamniaga?");
			trace("Flash Animata!");
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			KeyboardController.init(stage);
			application = App.getInstance();
			add(SceneView, {scene:application.scene});
			append(text("Click on the tree then use the keyboard to play (needs sound).", "Small"));
			append(new FPSView());
			
		}
	}
}
