package app.helpers {	import com.lbi.mvc.helper.TypographyBase;	/**	 * Generated with Tidy Flash	 * This is your application's 'stylesheet'	 * This works for TextField instances with one style.	 * The Typography constructor takes an argument that maps onto the name	 * of the method within which the style is defined	 * For example:	 * 		txt = Attach.TextField(this, new Typography("Paragraph"));	 * will result in the Paragraph method on your typography class being called	 * Defaults() is always called first	 */	public class Typography extends TypographyBase {		public function Typography(style:String) {			super(style);		}		public static function style( id: String) : TypographyBase{			return new Typography(id);		}		override protected function Defaults() : void {			super.Defaults();			embed_fonts = false;			font = "Arial";			font_size = 30;		}		public function Heading() : void{			font_size = 64;//			align = TextFormatAlign.CENTER;		}	}}