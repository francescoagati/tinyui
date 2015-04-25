# tinyui
A tiny UI macro for injecting ui items declared in a xml file into a haxe class

## example
#### SomeView.hx - the macro building class
```haxe
package com.sandinh.tinyui.example;

//those import is used in ui/some-view.xml
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign.CENTER;

@:build(com.sandinh.tinyui.UIMacro.build('ui/some-view.xml'))
class SomeView extends Sprite {
    private static inline var PADDING = 10;

    private function shouldEnableTxt(): Bool return true;
    
    public function new() {
        super();
        this.initUI(); //this method is auto-generated by tinyUI
    }
}
```

1. Is a normal haxe class which extends DisplayObjectContainer
2. annotated with `@:build(com.sandinh.tinyui.UIMacro.build('ui/some-view.xml'))`
3. import something for using in xml file. Here is Assets, Bitmap, CENTER,..
4. can access macro-generated fields: variables (declare in xml file) & function initUI()

#### some-view.xml - UI is declared here
```xml
<UI><!--name of root elem can be any-->
  <!--Here, Bitmap, Assets, CENTER is imported in SomeView.hx(the macro building class)-->
  
  <Bitmap var="bmp"
          new="new openfl.display.Bitmap(Assets.getBitmapData('img/sd.jpg'))"
          y="1 + 2" />
  <!--Here:
     + `PADDING` is the static var of the building class.
     + `shouldEnableTxt` is the method of the building class.
     + `bmp` is the variable of the building class,
        which is generated by tinyui's UIMacro because the above `var="bmp"` attribute of Bitmap node. -->
  <TextField y="bmp.y + bmp.height + PADDING"
             mouseEnabled="shouldEnableTxt()" >
    <TextFormat var="defaultTextFormat" size="18" font="'Tahoma'" align="CENTER" color="0xFF0000" />
    <String new="'sandinh.com'" var="text" />
  </TextField>
  
  <TextField text="'Hello TinyUI'">
    <TextFormat function="setTextFormat" size="18" font="'Tahoma'" align="CENTER" color="0xFF0000" />
  </TextField>
</UI>
```

1. Name of 1-level xml node (here is Bitmap, TextField) is the haxe class name.
    It must be a DisplayObject sub-class and must be imported in the building class code.
    
    An instance of this class will be create, init,
    then add as child of the building class object in `initUI()` macro-generated function.

2. XML attribute name is property of the instance. It can be nested,
   ex: `<TextField defaultTextFormat.size="18" />` //see Notes.

3. XML attribute value can be any haxe expression.

4. The nested (2+ level) xml node set values for properties of a nested complex property of the DisplayObject instance:
      ```xml
       <TextField>
         <TextFormat var="defaultTextFormat" size="18" align="CENTER" />
       </TextField>
       ```
      Note: The `var` attribute here is used as the nested var of TextField (parent node),
      not have same meaning as the `var` attribute of 1-level xml node
      (in which, `var` is used to declare an instance variable of the building class. see 6.)

5. Of course, we can have 3,4,..level of nesting xml nodes.

6. Special attributes:
    (note that the name of those attr is reversed word, so it will not conflict with normal property names)
    1. new="some expression has return type compatible with the node class name":
        + If Node do not have `new` attr then the instance is create using no-args constructor.
    2. var="someName"
        + If Node has `var` attribute then a variable with name "someName" will be created for the building class.
        + Else, the instance will be created as a local variable in initUI function
    3. function="someFun" in 2+ level node
        ```xml
        <TextField var="txt" text="'Hello TinyUI'">
            <TextFormat function="setTextFormat" size="18" font="'Tahoma'" />
        </TextField>
        ```
        will generate the following code:
        ```haxe
        var format = new TextFormat();
        format.size=18;
        format.font='Tahoma';
        this.txt.setTextFormat(format);
        ```
7. Save generated code to .hx files
    add the following flags to save generated code to ui-codegen folder:
    ```
    <haxeflag name="--macro" value="com.sandinh.tinyui.UIMacro.saveCodeTo('ui-codegen')"/>
    ```

8. target support: same as OpenFL (html5, flash, C++,..)

9. That's all!

### Notes
1. The following xml do NOT have same effect:
    ```xml
    <TextField>
     <TextFormat var="defaultTextFormat" size="18" />
    </TextField>
    ```
    vs
    ```xml
    <TextField defaultTextFormat.size="18" />
    ```
    because the generated code:
    ```haxe
    var format = new TextFormat();
    format.size = 18;
    txt.defaultTextFormat = format;
    ```
    vs
    ```haxe
    txt.defaultTextFormat.size = 18;
    ```
    is NOT same.
    In 2nd generated code, TextField.get_defaultTextFormat() is invoked, it return a clone TextFormat
     then when we set `.size = 18` on the cloned object, the original format is not changed!
2. You can see that there is NO trick in tinyui:
     All attribute value in xml file is just haxe expression
     that is eval - then can contains anything exist in the eval scope ( `initUI()` function ).
     
     Ex, in attribute `font="'Tahoma'"` has value 'Tahoma' - which is a String const.
        If you omit the (') chars, then haxe compiler will report error that identifier Tahoma is not exist!

### Licence
This software is licensed under the Apache 2 license:
http://www.apache.org/licenses/LICENSE-2.0

Copyright 2015 S�n ?�nh (http://sandinh.com)