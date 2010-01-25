package app.views {
	import app.controllers.App;
	import app.controllers.KeyboardController;
	import app.models.FlashVars;

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
			FlashVars.init(stage);
			KeyboardController.init(stage);
			application = App.getInstance();
			add(SceneView, {scene:application.scene});
	//		append(text("Click on the tree then use the keyboard to play (needs sound). Will stretch to fit window", "Small"));
		//	append(new FPSView())dfg;
			
		}
	}
}
