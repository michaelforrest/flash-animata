package app.controllers {
	import app.models.Scene;

	import com.lbi.mvc.model.Application;

	/**
	 * @author michaelforrest
	 */
	public class App extends Application {
		public function App() {
			super();
		}

		override protected function setup() : void {
			scene = new Scene({nmt:"forest/forest.nmt"});
		}
	}
}
