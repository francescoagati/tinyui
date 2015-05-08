import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Bitmap;
import openfl.Assets;
import layout.Direction;

using layout.LayoutUtils;

@:build(TinyUI.build('ui/13-layout.xml'))
class UI13Layout extends Sprite {
	//++++++++++ code gen by tinyui ++++++++++//
	public function initUI() {
		var largeFmt = new TextFormat("Tahoma", 22, 0xFF0000);
		var bmp1 = new flash.display.Bitmap(Assets.getBitmapData("img/sd.jpg"));
		this.addChild(bmp1);
		var __uiBitmap1 = new flash.display.Bitmap();
		__uiBitmap1.bitmapData = bmp1.bitmapData;
		__uiBitmap1.alignRight();
		__uiBitmap1.alignBottom(15);
		this.addChild(__uiBitmap1);
		var txt1 = new flash.text.TextField();
		txt1.text = "Hi & Layout!";
		txt1.width = 200;
		txt1.height = 33;
		txt1.setTextFormat(largeFmt);
		txt1.rightOf(bmp1, PADDING);
		this.addChild(txt1);
		var __uiTextField1 = new flash.text.TextField();
		__uiTextField1.text = "Hi Layout2!";
		__uiTextField1.width = 200;
		__uiTextField1.setTextFormat(largeFmt);
		__uiTextField1.alignWith(txt1, LEFT);
		__uiTextField1.below(txt1);
		this.addChild(__uiTextField1);
	}
	//---------- code gen by tinyui ----------//

    static inline var PADDING = 5;
    
    public function new() {
        super();
        initUI();
    }
}
