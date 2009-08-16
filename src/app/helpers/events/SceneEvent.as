package app.helpers.events {
	import Boolean;
	import String;
	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class SceneEvent extends Event {
		public static const READY : String = "READY";
		
		public function SceneEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
