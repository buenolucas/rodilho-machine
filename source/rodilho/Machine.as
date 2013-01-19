package rodilho {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    import flash.utils.setInterval;
    import flash.utils.setTimeout;

    import rodilho.display.Sheave;
    import rodilho.events.MachineEvent;

    import rodilho.events.ProviderEvent;
    import rodilho.events.SheaveEvent;
    import rodilho.intelligence.IIntelligence;
    import rodilho.provider.IDataProvider;
    import rodilho.util.ArrayUtil;


    public class Machine extends Sprite {

        //--------------
        //
        // events
        //
        //--------------
        [Event(name="changeState", type="rodilho.events.MachineEvent")]

        //--------------
        //
        // Properties
        //
        //--------------
        public var rodilhos:Sprite;
        public var provider:IDataProvider;
        public var intelligence:IIntelligence;
        public var sequence:Array;

        /*
        public var speed                    = 0;
        public var maxSpeed:Number          = 10;
        public var aceleration:Number      = .5;
        */

        //--------------------
        // shaking
        //--------------------
        private var _shaking:Boolean=false;


        public var rollInterval:int = 1000;
        public var raffleInterval:int = 3000;

        protected var timer:Timer;

        //private var interval:uint;

        //public var rollInterval:uint;


        //------------------------
        //  currentState
        //------------------------
        private var _currentState:String="idle";
        /**
         * indica o estado da maquina
         * idle:    parada
         * rolling  rodando
         */
        public function set currentState(value:String):void
        {
            if(value==_currentState)
                return;

            var oldState:String = currentState;
            var e:MachineEvent = new MachineEvent(MachineEvent.CHANGE_STATE, this, value, oldState)
            dispatchEvent(e);
        }
        public function get currentState():String
        {
            return _currentState;
        }

        //------------------------
        //  currentSubState
        //------------------------
        /**
         * sub estado
         * idle
         * * idle
         * rolling
         * * speedUp
         * * constant
         * * speedDown
         */
        public var currentSubState:String="idle";



        //--------------
        //
        // Constructor
        //
        //--------------
        public function Machine() {
            super();
            init();
        }

        //--------------
        //
        // Methods
        //
        //--------------
        public function init():void
        {
            rodilhos = new Sprite();
            addChild(rodilhos)
        }

        /**
         * inicializa a máquina
         */
        public function run():void
        {
            provider.addEventListener(ProviderEvent.LOAD_DATA, provider_loadDataHandler);
            provider.loadData();
        }

        /**
         * Cria a máquina de rodilhos.
         * O DataProvider precisa dos dados antes de inicializar a maquina
         */
        protected function createMachine():void
        {
            var len:int = sequence.length;
            for(var i:int =0;i<len; i++)
            {
                var s:Array = sequence[i];
                var data:Array=[]
                for(var c:int =0;c<s.length;c++)
                {
                    var di:Object = ArrayUtil.search(provider.data, "alias",s[c])
                    if(di)
                        data.push(di)
                }
                var l:Sheave = new Sheave(data);
                l.name = "sheave"+i;
                l.x = (MachineConfig.SLOT_WIDTH+MachineConfig.COLUMN_GAP)*i

                rodilhos.addChild(l)
            }
        }

        protected function attachSheaveEvents(sheave:Sheave):void
        {
            sheave.addEventListener(SheaveEvent.SHAKE_BEGIN, sheave_shakeBeginHandler);
            sheave.addEventListener(SheaveEvent.SHAKE_FINISHED, sheave_shakFinishedHandler);
        }
        protected function removeSheaveEvents(sheave:Sheave):void
        {
            sheave.removeEventListener(SheaveEvent.SHAKE_BEGIN, sheave_shakeBeginHandler);
            sheave.removeEventListener(SheaveEvent.SHAKE_FINISHED, sheave_shakFinishedHandler);
        }
        /**
         * chacualha a sorte do caboclo
         */
        public function shake():void
        {
            currentState = "rolling";
            /*
            for(var i:int = 0;i<sequence.length;i++)
            {
                var list:Sheave = rodilhos.getChildAt(i) as Sheave;
                attachSheaveEvents(list)
                list.shake();
            }
            */
            shakeSheave();
            addEventListener(Event.ENTER_FRAME, enterFrameHandler)
        }
        protected function shakeSheave(index:int=0):void
        {
            var s:Sheave = rodilhos.getChildAt(index) as Sheave;
            attachSheaveEvents(s)
            s.shake();
            index++;

            if(index<rodilhos.numChildren)
                setTimeout(shakeSheave,rollInterval,index);
            else
                s.addEventListener(SheaveEvent.TOP_SPEED, lastRodillho_topSpeedHandler)
        }

        /**
         * chacualha a sorte do caboclo
         */
        public function raffle():void
        {
            currentState = "rolling";
            for(var i:int = 0;i<sequence.length;i++)
            {
                var list:Sheave = rodilhos.getChildAt(i) as Sheave;
                list.raffle();
            }
           //addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        protected function raffleSheave(index:int=0):void
        {
            var s:Sheave = rodilhos.getChildAt(index) as Sheave;
            s.raffle();
            index++;
            if(index<rodilhos.numChildren)
               setTimeout(raffleSheave,rollInterval,index)
            else
                s.addEventListener(SheaveEvent.SHAKE_FINISHED, lastRodillho_shakeFinishedHandler)

        }
        //--------------
        //
        // Event Handlers
        //
        //--------------
        /**
         * chama o render das roldanas
         * @param event
         */
        private function enterFrameHandler(event:Event):void
        {
            var timer:int = getTimer();
            for(var i:int = 0;i<sequence.length;i++)
            {
                var list:Sheave = rodilhos.getChildAt(i) as Sheave;
                list.update(timer);
            }
        }

        /**
         * escuta o dataprovider
         * Quando o data provider carrega os dados dispara um evento
         * e so após a máquina deve ser construída
         *
         * @param e
         */
        protected function provider_loadDataHandler(e:ProviderEvent):void
        {
            createMachine();
        }

        /**
         * diparado quando a roldana comeca a rodar
         * @param event
         */
        private function sheave_shakeBeginHandler(event:SheaveEvent):void
        {
//            Console.log("Roldana '"+event.sheave.name+"', shake baby" )
        }

        /**
         * disparado quando a roldana para
         * @param event
         */
        private function sheave_shakFinishedHandler(event:SheaveEvent):void
        {
  //          Console.log("Roldana '"+event.sheave.name+"', finished!" )
        }


        private function lastRodillho_topSpeedHandler(event:SheaveEvent):void
        {
            event.sheave.removeEventListener(SheaveEvent.TOP_SPEED, lastRodillho_topSpeedHandler);
            setInterval(raffle,raffleInterval)

        }
        private function lastRodillho_shakeFinishedHandler(event:SheaveEvent):void
        {
            //event.sheave.removeEventListener(SheaveEvent.TOP_SPEED, lastRodillho_topSpeedHandler);
            //setInterval(raffle,raffleInterval)
            currentState = "idle";

        }
    }
}