package app.models {
	import com.lbi.mvc.view.ViewBase;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author michaelforrest
	 */
	public class Texture {
		public var x : Number;
		public var y : Number;
		public var scale : Number;
		public var image : BitmapData;

		public function Texture(child : XMLList, library : Class) {
			if(child == null) return; 
			try {
				var location : String = child.@location;
				location = location.replace(".png", "");
				image = (new library[location]() as Bitmap).bitmapData;
			}catch(e:Error){
				trace("Error loading " + library + " -> " + location);
			}
			x = child.@x;
			y = child.@y;
			scale = child.@scale;
			
		}

		public function getImage() : BitmapData {
			return image;
		}
	}
}
