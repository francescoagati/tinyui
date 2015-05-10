import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Bitmap;
import openfl.Assets;
import layout.Direction;

using layout.LayoutUtils;

@:build(TinyUI.build('ui/15-layout.xml'))
class UI15Layout extends Sprite {
    static inline var PADDING = 5;
    
    public function new() {
        super();
        initUI();
    }
}
