/**
 * Interface para obtenção das imagens
 */
package rodilho.provider {
    public interface IDataProvider {

        //retorna a coleçao de imagens
        function get data():Array

        function loadData(params:Object):void
    }
}
