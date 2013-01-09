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
    [Embed(source="../../assets/a.png")]
    private  var itemAClass:Class;

    [Embed(source="../../assets/b.png")]
    public  var itemBClass:Class;

    [Embed(source="../../assets/c.png")]
    private  var itemCClass:Class;

    [Embed(source="../../assets/d.png")]
    private var itemDClass:Class;

    [Embed(source="../../assets/e.png")]
    private var itemEClass:Class;

    [Embed(source="../../assets/f.png")]
    private var itemFClass:Class;

    //----------------------------
    //
    // properties
    //
    //----------------------------
    public var max:Number = 6;

    //retorna a coleçao de imagens
    public function get data():Array {
          return [];
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
            {alias:"A", reference: itemAClass, title: "Item A"},
            {alias:"B", reference: itemBClass, title: "Item B"},
            {alias:"C", reference: itemCClass, title: "Item C"},
            {alias:"D", reference: itemDClass, title: "Item D"},
            {alias:"E", reference: itemEClass, title: "Item E"},
            {alias:"F", reference: itemFClass, title: "Item F"}
        ];
        var e:ProviderEvent = new ProviderEvent(ProviderEvent.LOAD_DATA, a,  this);
        dispatchEvent(e);
    }


}
}
