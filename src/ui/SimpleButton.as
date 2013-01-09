package ui {
import flash.display.Sprite;
import flash.text.TextField;
import flash.events.*;
import flash.text.TextFormat;

public class SimpleButton extends Sprite {

    private var button:Sprite = new Sprite();

    public function SimpleButton() {
        drawButton()

        addChild(button);
    }

    private function drawButton():void {
        var textLabel:TextField = new TextField()
        button.graphics.clear();
        button.graphics.beginFill(0xD4D4D4); // grey color
        button.graphics.drawRoundRect(0, 0, 80, 36, 10, 10); // x, y, width, height, ellipseW, ellipseH
        button.graphics.endFill();
        textLabel.text = "Play!";
        textLabel.x = 10;
        textLabel.y = 5;
        textLabel.selectable = false;

        var fmt:TextFormat = new TextFormat();
        fmt.font = "Arial";
        fmt.size = 20
        textLabel.setTextFormat(fmt)
        button.addChild(textLabel)
    }

    private function mouseDownHandler(event:MouseEvent):void {
        button.x += 20

    }
}
}