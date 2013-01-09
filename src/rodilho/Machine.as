package rodilho {
import flash.display.Sprite;

import rodilho.events.ProviderEvent;
import rodilho.intelligence.IIntelligence;

import rodilho.provider.IDataProvider;

import util.Console;

public class Machine extends Sprite {

    public var provider:IDataProvider;
    public var intelligence:IIntelligence;
    public var sequence:Array;

    /**
     * total de colunas
     */
    public var cols:int = 5;

    /**
     * total de linhas
     */
    public var rows:int = 3;

    public var slotWidth:Number = 50;
    public var slotHeight:Number = 50;


    public var listPadding:Object = {left:4, top:4, right:4, bottom:4}
    public var slotSize:Object = {width:100,height:100}

    public function Machine() {
        super();
        init();
    }

    public function init()
    {

    }

    /**
     * inicializa a máquina
     */
    public function run()
    {
        provider.addEventListener(ProviderEvent.LOAD_DATA, provider_loadDataHandler);
        provider.loadData();
    }

    /**
     * Cria a máquina, disparado após adicionado ao palco
     */
    protected function createMachine():void
    {

    }

    protected function provider_loadDataHandler(e:ProviderEvent):void
    {
        createMachine();
    }
}
}
