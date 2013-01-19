package rodilho.animation
{
import flash.utils.getTimer;

public class Animation
    {
        public var target:Object
        public var targets:Array;



        public var fromValue:Number;
        public var toValueValue:Number;


        public var duration:Number;
        public var aceleration:Number;
        public var distance:Number;

        protected var initAt:int;
        protected var endAt:int;
        //public var easing:Function = Linear.easin;


        public function Animation(target:*)
        {
            if(target is Array)
                this.targets = target;
            else
                this.target = target;

        }
        public function play():void
        {
            initAt = getTimer();
            endAt = initAt+duration;
        }
        public function update(currentTime:Number):void
        {

        }
    }
}
