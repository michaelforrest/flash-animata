package app.models {
	import app.helpers.events.SceneEvent;

	import com.lbi.mvc.collection.Selectable;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author michaelforrest
	 */
	public class Scene extends Selectable {
		private var url : String;
		private var loader : URLLoader;
		private var folder : String;
		private var layer : Layer;

		public function Scene(options : Object) {
			url = options.nmt;
			folder = options.folder;
			loadXML(url);
		}
		
		private function loadXML(url : String) : void {
			loader = new URLLoader();
			var xml_request : URLRequest = new URLRequest(url);
			loader.load(xml_request);
			loader.addEventListener(Event.COMPLETE, onLoad,false,0,true);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress,false,0,true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError,false,0,true);
		}
		
		private function onError(event : IOErrorEvent) : void {
			throw new Error("Error loading " + url);
		}

		private function onProgress(event : ProgressEvent) : void {
		}

		private function onLoad(event : Event) : void {
			layer = new Layer(new XML(loader.data),folder);
			dispatchEvent(new Event(SceneEvent.READY));
		}
	}
}
