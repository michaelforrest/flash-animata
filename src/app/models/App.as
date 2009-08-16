package app.models {
	import com.lbi.mvc.model.EventMapper;

	import flash.events.Event;

	/**
	 * Generated with Tidy Flash
	 */
	public class App extends EventMapper {

		public static var READY : String = "ready";
		public function dispatchReady() : void {dispatchEvent(new Event(READY));}

		private static var instance : App;
		public static function getInstance() : App {
			if(!instance) instance = new App();
			return instance;
		}
		public function App() {
		}
	}
}