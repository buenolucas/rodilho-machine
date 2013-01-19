/**
 * Created with IntelliJ IDEA.
 * User: buenolucas
 * Date: 09/01/13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package rodilho.events {
import flash.events.Event;

import rodilho.Machine;

import rodilho.provider.IDataProvider;

public class MachineEvent extends Event {
    public static const CHANGE_STATE:String = "changeState";

    public var machine:Machine
    public var currentState:String;
    public var oldState:String;

    public function MachineEvent(type:String, machine:Machine, newState: String, oldState:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
        this.machine        = machine;
        this.currentState   = newState;
        this.oldState       = oldState;
    }
}
}
