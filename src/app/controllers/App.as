package app.controllers {
	import app.audio.Piano;
	import app.models.Scene;

	import forest.ForestLibrary;

	import com.lbi.mvc.model.EventMapper;

	/**
	 * @author michaelforrest
	 */
	public class App extends EventMapper {
		public var scene : Scene;
		
		private static var instance : App;
		public var piano : Piano;

		public static function getInstance() : App {
			if(!instance) instance = new App();
			return instance;
		}
		public function App() {
			scene = new Scene({nmt:"forest/forest.nmt", library:ForestLibrary});
			piano = new Piano(scene);
		}
		
	}
}
