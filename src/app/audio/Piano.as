package app.audio {
	import animata.models.Bone;

	import app.controllers.KeyboardController;
	import app.helpers.events.PianoEvent;
	import app.models.Scene;

	/**
	 * @author michaelforrest
	 */
	public class Piano {
		private var controller : KeyboardController;
		private var scene : Scene;

		public function Piano(scene : Scene) {
			this.scene = scene;
			controller = KeyboardController.getInstance();
			controller.registerEvents(this, [PianoEvent.NOTE_ON, PianoEvent.NOTE_OFF]);
		}
		public function onNoteOn( e : PianoEvent ) : void {
			setBonesTempo(e);
			triggerNote(e.note.getTriggerName());
		}
		
		private function triggerNote(triggerName : String) : void {
			var bones : Array = scene.findBones(triggerName);
			for (var i : int = 0; i < bones.length; i++) {
				var bone : Bone = bones[i];
				bone.setScale(1);
				bone.animateToScale(0);
			}
			
		}

		private function setBonesTempo(e : PianoEvent) : void {
			var bones : Array = scene.findBones(e.note.getBoneName());
			for (var i : int = 0; i < bones.length; i++) {
				var bone : Bone = bones[i];
				bone.setTempo(2);
				bone.animator.change("tempo").setFrames(60);
				bone.animateToTempo(0);
			}
		} 

		public function onNoteOff( e : PianoEvent ) : void{
			//setBonesTempo(0, e);
		} 
	}
}
