package rodilho {
    public class MachineConfig
    {
        //--------------
        //
        // Properties
        //
        //--------------

        /**
         * Largura do Slot
         */
        public static var SLOT_WIDTH:Number = 120;

        /**
         * Altura do Slot
         */
        public static var SLOT_HEIGHT:Number = 120;


        /**
         *  Velocidade maxima da rodlana
         */
        public static var MAX_SPEED:Number = 5;

        /**
         * tempo que dura o periodo de aceleracao
         */
        public static var ACELERATION_DURATION:Number = 10000;

        /**
         * tempo que dura o tempo de frenagem da roldana
         */
        public static var BREAK_DURATION:Number = 10000;

        /**
         * o sentido que geria a roldana em relacao ao scroll
         *
         * <code>reverse</code>
         * ou <code>normal</code>
         */
        public static var SHEAVE_ROTATION:String = "reverse"

        /**
         * a cor de fundo da roldana
         */
        public static var SHEAVE_BACKGROUND_COLOR:uint = 0xFFFFFF

        /**
         * alpha do background da roldana
         */
        public static var SHEAVE_BACKGROUND_ALPHA:int = 0;

        /**
         * Distância entre colunas
         */
        public static var COLUMN_GAP:Number = 20;

        /**
         * total de slots exibidos
         */
        public static var DISPLAYED_SLOTS:Number = 3;

    }
}