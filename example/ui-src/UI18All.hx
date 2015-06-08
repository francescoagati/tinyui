import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;

//all things in-scope is accessible in xml, include static extension methods
using com.sandinh.ui.BitmapTools;
using com.sandinh.TipTools;
using layout.LayoutUtils;

@:tinyui('ui/18-all.xml')
class UI18All extends Sprite {
    public function new() {
        super();
        //initUI is generated by TinyUI
        initUI(10, 20);
    }
    //those method is called from xml
    function simpleMethod(msg: String){
        //myFmt, uiMode, UI_m2 is generated by TinyUI
        trace(msg + this.myFmt.bold);
        this.uiMode = UI_m2;
    }
    function myMethod(i1: Int, msg: String){ }
    function complexMethod(i1: Int, tf: TextFormat, i2: Int){ }
    function methodCreateSprite(): Sprite {
        return new Sprite();
    }
}
