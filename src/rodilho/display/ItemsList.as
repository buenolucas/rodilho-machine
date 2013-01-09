/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 17:05
 * To change this template use File | Settings | File Templates.
 */
package rodilho.display {
import flash.display.Shape;
import flash.display.Sprite;

import rodilho.MachineConfig;

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

    }
    //--------------
    //
    // Event Handlers
    //
    //--------------        
}
}
