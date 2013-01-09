/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 17:33
 * To change this template use File | Settings | File Templates.
 */
package rodilho.display {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;

import rodilho.MachineConfig;

import util.Console;

public class Slot extends Sprite {
    //--------------
    //
    // Properties
    //
    //--------------
    /**
     * informações sobre o item
     */
    public var data:Object;

    /**
     * imagem
     */
    public var imageDisplay:*

    /**
     * mascara
     */
    public var maskDisplay:Sprite;

    /**
     * container
     */
    public var container:Sprite;

    //--------------
    //
    // Constructor
    //
    //--------------
    public function Slot(data:Object) {
        super();
        this.data = data;
        graphics.lineStyle(1,0xFF0000);
        graphics.drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT);
        graphics.endFill();

        container = new Sprite();
        addChild(container)
        if(data.reference is Class)
        {
            imageDisplay = new data.reference();
            adjustSize()
        }
        else if(data.reference is String)
        {
            imageDisplay = new Loader();
            imageDisplay.contentLoaderInfo.addEventListener(Event.COMPLETE, imageDisplay_completeHandler)
            imageDisplay.load(new URLRequest(data.reference))
        }
        container.addChild(imageDisplay)

        maskDisplay = new Sprite();
        with(maskDisplay.graphics)
        {
            beginFill(0x00FF00)
            drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT);
            endFill()
        }
        addChild(maskDisplay)
        container.mask = maskDisplay

    }

    /**
     * redimenciona e centraliza a imagem conforme tamanho do slot
     */
    protected function adjustSize():void
    {
        var imgWidth:Number     = imageDisplay is Loader ? imageDisplay.content.width : imageDisplay.width;
        var imgHeight:Number    = imageDisplay is Loader ? imageDisplay.content.height : imageDisplay.height;

        var boundsRatio:Number = MachineConfig.SLOT_HEIGHT/MachineConfig.SLOT_WIDTH;
        var imageRatio:Number = imgHeight/imgWidth;

        Console.log(imgWidth+","+imgHeight)
        var widthTo:Number;
        var heightTo:Number;
        var xTo:Number;
        var yTo:Number;

        if(imageRatio>boundsRatio)
        {
            //ajustar pela largura
            widthTo = MachineConfig.SLOT_WIDTH;
            heightTo = Math.round(widthTo*imageRatio);
            xTo = 0;
            yTo = Math.round((MachineConfig.SLOT_HEIGHT - heightTo)/2);
        } else
        {
            //ajustar pela altura
            imageRatio = imgWidth / imgHeight;
            heightTo = MachineConfig.SLOT_HEIGHT;
            widthTo = Math.round(heightTo*imageRatio);
            xTo = Math.round((MachineConfig.SLOT_WIDTH - widthTo)/2);
            yTo = 0
        }
        imageDisplay.width = widthTo;
        imageDisplay.height = heightTo;
        imageDisplay.x = xTo;
        imageDisplay.y = yTo;
    }
    protected function imageDisplay_completeHandler(e:Event):void
    {
        var imageLoader:Loader = Loader(e.target.loader);
        var bm:Bitmap = Bitmap(imageLoader.content);
        adjustSize();

    }

    //--------------
    //
    // Methods
    //
    //--------------

    //--------------
    //
    // Event Handlers
    //
    //--------------        
}
}
