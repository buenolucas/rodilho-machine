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
    import rodilho.display.Sheave;

    import rodilho.provider.IDataProvider;

    public class SheaveEvent extends Event
    {
        public static const SHAKE_BEGIN:String = "shakeBegin";
        public static const TOP_SPEED:String = "topSpeed";
        public static const SHAKE_BREAK:String = "shakeBreak";
        public static const SHAKE_FINISHED:String = "shakeFinished";

        public var sheave:Sheave;

        public function SheaveEvent(type:String,  sheave:Sheave, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.sheave        = sheave;
        }
    }
}
