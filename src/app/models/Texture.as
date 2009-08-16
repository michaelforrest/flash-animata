package app.models {
	import flash.display.Bitmap;

	/**
	 * @author michaelforrest
	 */
	public class Texture {
		private var location : String;
		public var x : Number;
		public var y : Number;
		public var scale : Number;
		public var image : Bitmap; 

		public function Texture(child : XML, folder : String) {
			if(child == null) return; 
			location = folder + "/" + child.getStringAttribute("location");
			x = child.getFloatAttribute("x");
			y = child.getFloatAttribute("y");
			scale = child.getFloatAttribute("scale");
		}

		public function  getImage() : Bitmap {
			trace("WARNING! Loading this image won't work!");
			//	if(image==null) image = applet.loadImage(location);
			return image;
		}
	}
}
