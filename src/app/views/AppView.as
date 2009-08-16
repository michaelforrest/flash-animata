package app.views {
	import app.controllers.App;

	import com.lbi.mvc.view.ViewBase;

	/**
	 * @author michaelforrest
	 */
	public class AppView extends ViewBase {
		private var application : App;
		
		public function AppView() {
			super({});
			application = App.getInstance();
			add(SceneView, {scene:application.scene});
		}
	}
}
