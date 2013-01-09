package rodilho {
import flash.display.Sprite;

import rodilho.events.ProviderEvent;

import rodilho.provider.IDataProvider;

public class Machine extends Sprite {

    public var provider:IDataProvider;




    public function Machine() {
        super();
        init();
    }

    public function init()
    {

    }
    public function render()
    {
        provider.addEventListener(ProviderEvent.LOAD_DATA, provider_loadDataHandler);
    }

    public function createMachine():void
    {

    }

    protected function provider_loadDataHandler(e:ProviderEvent):void
    {

    }
}
}
