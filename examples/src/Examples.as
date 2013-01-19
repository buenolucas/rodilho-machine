package {

import flash.display.Sprite;
import flash.text.TextField


public class Examples extends Sprite {
    public function Examples() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
    }
}
}
