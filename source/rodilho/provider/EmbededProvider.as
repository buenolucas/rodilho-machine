package rodilho.provider {
import flash.display.Sprite;

import rodilho.events.ProviderEvent;

public class EmbededProvider extends Sprite implements IDataProvider {

    //--------------
    //
    // events
    //
    //--------------
    [Event(name="loadData", type="rodilho.events.ProviderEvent")]

    //----------------------------
    //
    // embedded
    //
    //----------------------------
   /*
    [Embed(source="../../assets/fruits/a.png")]
    private  var itemAClass:Class;

    [Embed(source="../../assets/fruits/b.png")]
    public  var itemBClass:Class;

    [Embed(source="../../assets/fruits/c.png")]
    private  var itemCClass:Class;

    [Embed(source="../../assets/fruits/d.png")]
    private var itemDClass:Class;

    [Embed(source="../../assets/fruits/e.png")]
    private var itemEClass:Class;

    [Embed(source="../../assets/fruits/f.png")]
    private var itemFClass:Class;
                     */
    //----------------------------
    //
    // properties
    //
    //----------------------------
    public var max:Number = 6;

    /**
     * retorna a coleção de imagens
     */
    private var _data:Array;
    public function get data():Array {
        return _data;
    }

    //----------------------------
    //
    // constructor
    //
    //----------------------------

    public function EmbededProvider() {
        super();
    }

    //----------------------------
    //
    // methdos
    //
    //----------------------------
    public function loadData(params:Object= null):void
    {
        getCollection()
    }

    protected function getCollection():void
    {
        var a:Array = [
           /* {alias:"A", reference: itemAClass, label: "Item A", color:0xFF0000},
            {alias:"B", reference: itemBClass, label: "Item B", color:0x00FF00},
            {alias:"C", reference: itemCClass, label: "Item C", color:0x0000FF},
            {alias:"D", reference: itemDClass, label: "Item D", color:0xFFFF00},
            {alias:"E", reference: itemEClass, label: "Item E", color:0x00FFFF},
            {alias:"F", reference: itemFClass, label: "Item F", color:0x006600}*/
        ];
        _data = a;
        var e:ProviderEvent = new ProviderEvent(ProviderEvent.LOAD_DATA, a,  this);
        dispatchEvent(e);
    }


}
}
