package app.controllers {
	import app.audio.Piano;
	import app.helpers.events.SceneEvent;
	import app.models.FlashVars;
	import app.models.Scene;

	import forest.ForestLibrary;

	import com.lbi.mvc.model.EventMapper;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class App extends EventMapper {
		public var scene : Scene;
		
		private static var instance : App;
		public var piano : Piano;
		public static const WIREFRAME : Number = 3;
		public static const CHANGING : Number = 2;
		public static const FULL : Number = 1;
		public static var renderMode : Number = FULL;

		public static function setRenderMode(mode : Number) : void {
			renderMode = mode;
			getInstance().dispatchEvent(new Event( SceneEvent.MODE_CHANGED));
		}

		public static function getInstance() : App {
			if(!instance) instance = new App();
			return instance;
		}
		public function App() {
			scene = new Scene({nmt:FlashVars.getString("nmt") || "forest/forest.nmt", library:ForestLibrary});
			piano = new Piano(scene);
		}
		
	}
}
