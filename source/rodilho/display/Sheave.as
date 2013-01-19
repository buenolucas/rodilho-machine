package rodilho.display
{

import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.getTimer;
    import rodilho.Machine;
    import rodilho.MachineConfig;
import rodilho.animation.easing.Back;
import rodilho.animation.easing.Quad;
    import rodilho.events.SheaveEvent;

    public class Sheave extends Sprite
    {
        //--------------
        //
        // events
        //
        //--------------
        /**
         * diparado quando a roldana comeca a girar
         */
        [Event(name="shakeBegin", type="rodilho.events.SheaveEvent")]

        /**
         * atinge a velocidade maxima
         */
        [Event(name="topSpeed", type="rodilho.events.SheaveEvent")]

        /**
         * quando roldana comeca a freiar
         */
        [Event(name="shakeBreak", type="rodilho.events.SheaveEvent")]

        /**
         * disparado quando a roldana para
         */
        [Event(name="shakeFinished", type="rodilho.events.SheaveEvent")]

        //--------------
        //
        // Properties
        //
        //--------------

        public var machine:Machine;

        public var maskDisplay:Sprite;
        public var container:Sprite;
        public var items:Sprite;
        public var background:Sprite;

        /**
         * Coleção de slots
         */
        public var data:Array;

        public var currentSlot:Slot;
        public var currentIndex:int;

        public var currentState:String = "idle";
        public var currentSubState:String = "idle";

        //-------------
        // startAt
        //-------------
        private var _startAt:int

        public function set startAt(value:int):void
        {
            _startAt = value;
        }
        public function get startAt():int
        {
            return _startAt;
        }

        //-------------
        // endAt
        //-------------
        private var _endAt:int;
        /**
         * ultimo indice da lista de rodilhos sorteados
         */

        public function get endAt():int {
            return _endAt;
        }

        //-------------
        // scrollPosition
        //-------------
        private var _scrollPosition:Number;

        /**
         * define a posição do scroll
         */
        public function get scrollPosition():Number
        {
            return _scrollPosition;
        }
        public function set scrollPosition(value:Number):void
        {
            if(_scrollPosition== value)
                return
            _scrollPosition = value;
        }

        //-------------
        // length
        //-------------
        /**
         * total de elementos na colecao
         */
        public function get length():int
        {
            return data.length;
        }

        //-------------
        // slotHeight
        //-------------
        /**
         * altura do slot
         */
        public function get slotHeight():int
        {
            return MachineConfig.SLOT_HEIGHT;
        }

        //-------------
        // rotationMode
        //-------------
        /**
         * modo de retacao da engrenagem relacionada ao valor de scrollPosition
         */
        public function get rotationMode():String
        {
            return MachineConfig.SHEAVE_ROTATION;
        }

        //-------------
        // visibleSlots
        //-------------
        /**
         * total de slots exibidos (total de linhas)
         */
        public function get visibleSlots():int
        {
            return MachineConfig.DISPLAYED_SLOTS;
        }

        //-------------
        // accelerationDuration
        //-------------
        /**
         * duracao da aceleracao
         */
        public var accelerationDuration:Number = 2.2;

        //-------------
        // accelerationDuration
        //-------------
        /**
         * total de slots para atingir a máxima acelercao
         */
        public var accelerationDistance:Number = 6;



        //---------------------------
        // accelerationDuration
        //---------------------------
        /**
         * total de slots percorridos ate parar completamente a roldana
         */
        public var breakDuration:Number = 2.2;

        //-------------
        // breakDistance
        //-------------
        /**
         * tempo de duracao da frenagem
         */
        public var breakDistance:Number = 12;

        //-------------
        // maxSpeed
        //-------------
        /**
         * velocidade maxima
         */
        public var maxSpeed:Number = 0;

        public var speed:Number             = 0;
        public var acceleration:Number       = .01;

        protected var scrollFrom:Number;
        protected var scrollTo:Number;

        private var startStateAt:int;
        private var finalPosition:Number;



        //--------------
        //
        // Constructor
        //
        //--------------
        public function Sheave(data:Array)
        {
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
            //cria container
            container = new Sprite();
            background = new Sprite();

            with(background.graphics)
            {
                beginFill(MachineConfig.SHEAVE_BACKGROUND_COLOR, MachineConfig.SHEAVE_BACKGROUND_ALPHA);
                drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT*data.length);
                endFill();
            }
            //ajusta a posi;áo do background
            background.y = MachineConfig.SLOT_HEIGHT*visibleSlots-background.height;
            container.addChild(background);

            //cria container para os slots
            items = new Sprite();
            container.addChild(items);
            addChild(container);

            //cria os slots Slots
            for(var i:int = 0;i<data.length; i++)
            {
                var s:Slot = new Slot(data[i]);
                s.y= MachineConfig.SLOT_HEIGHT*i
                items.addChild(s)
            }

            //cria a mascara da roldana
            maskDisplay = new Sprite();
            with(maskDisplay.graphics)
            {
                beginFill(0x00FF00,1);
                drawRect(0,0,MachineConfig.SLOT_WIDTH,MachineConfig.SLOT_HEIGHT*MachineConfig.DISPLAYED_SLOTS)
                endFill()
            }
            addChild(maskDisplay);
            container.mask = maskDisplay;

            //outros ajustes
            scrollPosition = 0;
        }

        /**
         * gira a roldana
         */
        public function shake():void
        {
            //if(currentState!="idle")
            //    return;
            currentState="rolling"
            currentSubState="speedUp";

            var e:SheaveEvent = new SheaveEvent(SheaveEvent.SHAKE_BEGIN, this)
            dispatchEvent(e);

            //reposiciona a lista
            maxSpeed=0;
            //restoreScrollPosition();

            //ajusta transicao
            startStateAt = getTimer();
            scrollFrom = scrollPosition;
            scrollTo = (accelerationDistance*slotHeight)+scrollPosition;
            //maxSpeed
        }

        /**
         * rola com uma velocidade constante
         */
        public function rollLinear(speed:Number = NaN):void
        {
            currentSubState = "constant";
            if(!isNaN(speed))
            {
               this.maxSpeed = speed;
            }
            //restoreScrollPosition();
            var e:SheaveEvent = new SheaveEvent(SheaveEvent.TOP_SPEED, this)
            dispatchEvent(e);
        }

        /**
         * raffle
         */
        public function raffle():void
        {
            currentSubState = "speedDown";

            var e:SheaveEvent = new SheaveEvent(SheaveEvent.SHAKE_BREAK, this);
            dispatchEvent(e);

            //reposiciona a lista
            //restoreScrollPosition();

            //ajusta transicao
            startStateAt = getTimer();
            scrollFrom = scrollPosition;
            scrollTo = (breakDistance*slotHeight)+scrollPosition;
            //maxSpeed

        }

        /**
         * para a roldana
         */
        public function finish():void
        {
            currentState = currentSubState = "idle";

            var e:SheaveEvent = new SheaveEvent(SheaveEvent.SHAKE_FINISHED, this)
            dispatchEvent(e);
        }

        /**
         * atualiza o displaylist
         */
        public function update(timer:int):void
        {
            var t:Number;
            var newValue:Number;

            if(currentState=="rolling")
            {
                if(currentSubState=="speedUp")
                {
                    t = (timer - startStateAt)*.001
                    newValue = Quad.easeIn(t, 0, scrollTo - scrollFrom, accelerationDuration);
                    newValue = scrollFrom+newValue;
                    speed = newValue-scrollPosition;
                    if(speed>maxSpeed)
                        maxSpeed = speed;

                    if(t/accelerationDuration>=1)
                    {
                        rollLinear();
                        return;
                    }
                }
                else if(currentSubState=="constant")
                {
                    newValue = scrollPosition+maxSpeed;
                }
                else if(currentSubState=="speedDown")
                {
                    t = (timer - startStateAt)*.001;
                    newValue = Back.easeOut(t, 0, scrollTo - scrollFrom, breakDistance);
                    newValue = scrollFrom+newValue
                    speed = newValue-scrollPosition;
                    if(speed>maxSpeed)
                    {
                        //speed = maxSpeed;
                        //newValue = scrollPosition+speed;
                    }

                    //if(speed>maxSpeed)
                    //    maxSpeed = speed;

                    if(t/breakDistance>=1)
                    {
                        finish();
                        return;
                    }
                }
                scrollPosition = newValue;
                updateSlots();
            }
        }


        /**
         * atualiza a posicao da lista e os slots
         */
        protected function updateSlots():void
        {
            var sheaveHeight:Number = (slotHeight*length);
            var numPages:Number = Math.floor(scrollPosition/sheaveHeight);
            var rscroll:Number = scrollPosition-(numPages*sheaveHeight);

            var generatedIndex:int = Math.floor(rscroll/slotHeight);
            var newStartAt:int =  (rotationMode=="reverse" && generatedIndex!=0)  ? length-generatedIndex : generatedIndex
            if(newStartAt!= startAt)
            {
                startAt = newStartAt;
                //Console.log(newStartAt)
                adjustSlots(startAt);
            }
            rscroll = rscroll-(generatedIndex*slotHeight);
            var current:DisplayObject = items.getChildAt(startAt);

            container.y = rscroll;
        }
        /**
         * posiciona os slots em ordem de exibicao
         *
         * @param relativeTo
         */
        protected function adjustSlots(relativeTo:int = 0):void
        {
           // Console.log("Adjusting relativeTo"+relativeTo+ "==============")
            for(var i:int=0;i<length;i++)
            {
                var ci:int = relativeTo+i;
                ci = ci<length  ? ci : ci-length
                var s:Slot = items.getChildAt(ci) as Slot;
                //Console.log(s.name+" > i>"+ i+" ci>"+ci+" label>"+Slot(s).data.label+" index>" +items.getChildIndex(s))

                s.y = ((i<visibleSlots) ? i : -(length-i))*slotHeight
            }
        }

        /**
         * restaura a posicao do scroll
         * @return
         */
        protected function restoreScrollPosition():Number
        {
            var startAt:int = isNaN(this.startAt) ? 0 : this.startAt
            scrollPosition = startAt*slotHeight+container.y;
            return scrollPosition;
        }
        //--------------
        //
        // Event Handlers
        //
        //--------------

    }
}
