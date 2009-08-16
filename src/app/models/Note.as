package app.models {
	import flash.media.Sound;

	import audio.AudioLibrary;
	/**
	 * @author michaelforrest
	 */
	public class Note {
		private var key : String;
		private var index : int;
		private var sound : Sound;

		function Note(options : Object) {
			index = options.index;
			key = options.key;
			try{
				sound = new AudioLibrary["note" + index]() as Sound;
			}catch(e: Error){
				trace("error loading sound ", "note"+ index);
			}
		}
		public function stop() : void {
		}
		
		public function play() : void {
			sound.play();
		}
	}
}
