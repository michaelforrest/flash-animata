package app.helpers.events {
	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class PianoEvent extends Event {
		public function PianoEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
