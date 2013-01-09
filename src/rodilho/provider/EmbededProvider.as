/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 13:33
 * To change this template use File | Settings | File Templates.
 */
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
    [Embed(source="../assets/a.png")]
    [Bindable]
    public static var itemAClass:Class;

    [Embed(source="../assets/b.png")]
    [Bindable]
    public static var itemBClass:Class;

    [Embed(source="../assets/c.png")]
    [Bindable]
    public static var itemCClass:Class;

    [Embed(source="../assets/d.png")]
    [Bindable]
    public static var itemDClass:Class;

    [Embed(source="../assets/e.png")]
    [Bindable]
    public static var itemEClass:Class;

    [Embed(source="../assets/f.png")]
    [Bindable]
    public static var itemFClass:Class;

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

    public function loadData(params:Object):void
    {

        getCollection()
    }

    protected function getCollection():void
    {
        var a:Array = [];
        var e:ProviderEvent = new ProviderEvent(ProviderEvent.LOAD_DATA, a,  this);
        dispatchEvent(e)     ;
    }


}
}
