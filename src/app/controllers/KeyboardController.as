package app.controllers {
	import app.helpers.events.PianoEvent;
	import app.models.Note;

	import com.lbi.mvc.model.EventMapper;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	/**
	 * @author michaelforrest
	 */
	public class KeyboardController extends EventMapper {

		private static var instance : KeyboardController;
		private static const NUM_NOTES : Number = 21;//22;
		public static const KEYS : String = "asdfghjkl;zxcvbnm,.qwertyuiop";
		private var notes : Object = {};

		
		public static function getInstance() : KeyboardController {
			return instance;
		}

		public function KeyboardController(stage : Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addNotes();
		}
		
		private function addNotes() : void {
			for (var i : int = 0; i < NUM_NOTES; i++) {
				var char : String = KEYS.charAt(i);
				var note : Note = new Note({index:i, key:char });
				notes[char] = note;
			}
		}

		private function onKeyDown(event : KeyboardEvent) : void {
			var note : Note = getNoteByCharCode(event.charCode);
			if(!note) return;
			note.play();
			dispatchEvent(new PianoEvent(PianoEvent.NOTE_ON, note));
		}
		private function onKeyUp(event : KeyboardEvent) : void {
			var note : Note = getNoteByCharCode(event.charCode);
			if(!note) return;
			note.stop();
			dispatchEvent(new PianoEvent(PianoEvent.NOTE_OFF, note));
		}

		
		private function getNoteByCharCode(charCode : uint) : Note {
			var result :Note = notes[String.fromCharCode(charCode)];
			
			return result;
		}


		public static function init(stage : Stage) : void {
			instance= new KeyboardController(stage);
		}
	}
}
