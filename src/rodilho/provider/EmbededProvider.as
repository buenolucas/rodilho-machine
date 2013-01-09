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


    [Event(name="loadData", type="rodilho.events.ProviderEvent")]

    public var max:Number = 6;

    public function EmbededProvider() {
        super();
    }

    //retorna a coleçao de imagens
    public function get data():Array {
          return [];
    }

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
