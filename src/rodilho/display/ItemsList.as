/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 17:05
 * To change this template use File | Settings | File Templates.
 */
package rodilho.display {
import com.greensock.TweenLite;

import flash.display.Shape;
import flash.display.Sprite;

import rodilho.MachineConfig;

import util.Console;

public class ItemsList extends Sprite {
    //--------------
    //
    // Properties
    //
    //--------------

    public var maskDisplay:Sprite;
    public var container:Sprite;
    public var items:Sprite;
    public var background:Sprite;

    /**
     * Coleção de slots
     */
    public var data:Array;

    public var currentSlot:Slot;
    public var currentIndex:int;

    //-------------
    // scrollPosition
    //-------------
    private var _scrollPosition:Number;

    /**
     * define a posição do scroll
     */
    public function get scrollPosition():Number
    {
        return _scrollPosition;
    }
    public function set scrollPosition(value:Number):void
    {

        if(_scrollPosition== value)
            return

        /*
        _scrollPosition = value;
        var part:Number =   background.height-maskDisplay.height;
        var newPos:Number = value-(Math.floor(value/part)*part);
        container.y =  newPos-part;
        */

        //container.y = background.height-mask.height;

    }
    //--------------
    //
    // Constructor
    //
    //--------------
    public function ItemsList(data:Array) {
        super();
        this.data = data;
        init();
    }
    //--------------
    //
    // Methods
    //
    //--------------
    public function init():void
    {
        //ajustar a coleçacao
        /*
        var ndata:Array = [];
        for(var i:int=data.length-1;i>=0;i--)
        {
            var index:int = (i>=MachineConfig.DISPLAYED_SLOTS) ? i :  MachineConfig.DISPLAYED_SLOTS-1-i;
            ndata.push(data[index]);
            //var ri:int;
        }
         data = ndata
        */

        container = new Sprite();
        background = new Sprite();

        with(background.graphics)
        {
            beginFill(0x666666);
            drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT*data.length)
            endFill()
        }
        container.addChild(background);

        items = new Sprite();
        container.addChild(items);
        addChild(container);

        //add Slots
        for(var i:int = 0;i<data.length; i++)
        {
            var s:Slot = new Slot(data[i]);
            s.y= MachineConfig.SLOT_HEIGHT*i
            items.addChild(s)
        }

        maskDisplay = new Sprite();
        with(maskDisplay.graphics)
        {
            beginFill(0x00FF00,1);
            drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT*MachineConfig.DISPLAYED_SLOTS)
            endFill()
        }
        addChild(maskDisplay);
        container.mask = maskDisplay;

        scrollPosition = 0;

    }
    public function shake():void
    {
        TweenLite.to(this, 10, {scrollPosition:1500});
    }
    //--------------
    //
    // Event Handlers
    //
    //--------------        
}
}
