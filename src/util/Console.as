/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 14:27
 * To change this template use File | Settings | File Templates.
 */
package util {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.display.Graphics;
import flash.text.TextFormat;

import util.Console;

public class Console extends Sprite {

    protected var textDisplay:TextField;
    protected var chromeDisplay:Shape;
    private var fmt:TextFormat;

    private static var instance:Console;

    public var consoleWidth:Number  = 500;
    public var consoleHeight:Number = 700;

    public function Console() {
        super();

        if(!instance)
            instance = this;

        chromeDisplay = new Shape();
        addChild(chromeDisplay);

        textDisplay = new TextField();
        textDisplay.wordWrap=true;
        textDisplay.multiline=true;

        addChild(textDisplay);

        addEventListener(Event.ADDED_TO_STAGE,init)
    }
    protected function init(e:* = null):void
    {
        chromeDisplay.graphics.beginFill(0xCCCCCC,.7);
        chromeDisplay.graphics.drawRect(0,0,consoleWidth,consoleHeight);


        textDisplay.width = consoleWidth;
        textDisplay.height = consoleHeight;
        fmt =new TextFormat()
        fmt.size = 16;
        fmt.font = "Courier New";
        fmt.color = 0x00FF00
        textDisplay.setTextFormat(fmt)
    }
    public static function log(text:String):void
    {
        instance.textDisplay.appendText("# "+text+"\n")
    }


}
}
