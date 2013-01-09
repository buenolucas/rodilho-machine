/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package rodilho.events {
import flash.events.Event;

public class ProviderEvent extends Event {
    public function ProviderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
}
