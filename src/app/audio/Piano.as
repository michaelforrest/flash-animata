package app.audio {
	import app.helpers.events.PianoEvent;
	import app.controllers.KeyboardController;
	/**
	 * @author michaelforrest
	 */
	public class Piano {
		private var controller : KeyboardController;
		
		public function Piano() {
			controller = KeyboardController.getInstance();
			controller.registerEvents(this, [PianoEvent.NOTE_ON, PianoEvent.NOTE_OFF]);
		}
	}
}
