package app.views {
	import textures.TextureLibrary;

	import com.lbi.mvc.view.ViewBase;

	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.events.Event;

	/**
	 * Generated with Tidy Flash
	 * http://www.senocular.com/flash/tutorials/flash10drawingapi/
	 */

	public class AppView extends ViewBase {
		private var texture : Bitmap;
		
		public function AppView() {
			super({columnWidth:500});
			texture = new TextureLibrary.Capricious_4_by_Kinz90() as Bitmap;
			append(texture);
			append(text("Crazy about you.", "Heading"));
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
					   
		}
		
		private function onEnterFrame(event : Event) : void {
			drawATriangle();
		}

		private function drawATriangle() : void {
			var g : Graphics = graphics;
			g.clear();
			g.beginBitmapFill(texture.bitmapData);
			g.drawTriangles(Vector.<Number>([600,10,  1000,10,  mouseX, mouseY]),
											null,
							Vector.<Number>([0,0, 1,0, 0,1]));
		}
	}
}