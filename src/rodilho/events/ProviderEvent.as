/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package rodilho.events {
import flash.events.Event;

import rodilho.provider.IDataProvider;

public class ProviderEvent extends Event {
    public static const LOAD_DATA:String = "loadData";

    public var collection:Array;
    public var provider:IDataProvider;

    public function ProviderEvent(type:String, collection:Array, provider:IDataProvider, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
        this.collection = collection;
        this.provider = provider;
    }
}
}
