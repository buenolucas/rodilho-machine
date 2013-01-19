package rodilho.util {
    public class ArrayUtil
    {
        /**
         * busca o índice de um array deacordo com o valor da propriedade enviada
         *
         * @param collection
         * @param propertie
         * @param value
         * @return
         */
        public static function searchIndex(collection:Array, propertie:String, value:*):int
        {
            for(var i:int=0;i<collection.length;i++)
            {
                var it:Object = collection[i];
                if(it.hasOwnProperty(propertie) && it[propertie]==value)
                    return i
            }
            return -1
        }

        /**
         * busca o elemento corresponte ao valor da propriedade enviada
         * @param collection
         * @param propertie
         * @param value
         * @return
         */
        public static function search(collection:Array, propertie:String, value:*):Object
        {
            for(var i:int=0;i<collection.length;i++)
            {
                var it:Object = collection[i];
                if(it.hasOwnProperty(propertie) && it[propertie]==value)
                    return it
            }
            return null
        }
    }
}
