/**
 * Interface para obtenção das imagens
 */
package rodilho.provider
{
    import flash.events.IEventDispatcher

    public interface IDataProvider extends IEventDispatcher{

        //retorna a coleçao de imagens
        function get data():Array

        function loadData(params:Object):void
    }
}
