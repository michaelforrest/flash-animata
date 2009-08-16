package app.helpers.events {
	import app.models.Note;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class PianoEvent extends Event {
		public static const NOTE_ON: String = "NOTE_ON";
		public static const NOTE_OFF : String = "NOTE_OFF";
		public var note : Note;

		public function PianoEvent(type : String, note : Note) {
			super(type);
			this.note = note; 
		}
		
		
	}
}
