package app.controllers {
	import flash.display.StageDisplayState;
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
		private var stage : Stage;

		
		public static function getInstance() : KeyboardController {
			return instance;
		}

		public function KeyboardController(stage : Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.stage = stage; 
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
			if(String.fromCharCode(event.charCode) == "1") App.setRenderMode(App.FULL);
			if(String.fromCharCode(event.charCode) == "2") App.setRenderMode(App.CHANGING);
			if(String.fromCharCode(event.charCode) == "3") App.setRenderMode(App.WIREFRAME);
			
//			if(String.fromCharCode(event.charCode) == "0") stage.displayState = StageDisplayState.FULL_SCREEN;
			
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
			var result :Note = notes[String.fromCharCode(charCode).toLowerCase()];
			
			return result;
		}


		public static function init(stage : Stage) : void {
			instance= new KeyboardController(stage);
		}
	}
}
