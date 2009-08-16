package app.views {
	import app.controllers.KeyboardController;
	import app.controllers.App;

	import com.lbi.mvc.view.ViewBase;

	/**
	 * @author michaelforrest
	 */
	public class AppView extends ViewBase {
		private var application : App;
		
		public function AppView() {
			super({});
			trace("Flamniaga?");
			trace("Flash Animata!");
			application = App.getInstance();
			add(SceneView, {scene:application.scene});
			KeyboardController.init(stage);
		}
	}
}
