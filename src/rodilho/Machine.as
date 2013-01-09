package rodilho {
import flash.display.Sprite;

import rodilho.display.ItemsList;

import rodilho.events.ProviderEvent;
import rodilho.intelligence.IIntelligence;

import rodilho.provider.IDataProvider;

import util.ArrayUtil;

import util.Console;

public class Machine extends Sprite {

    public var provider:IDataProvider;
    public var intelligence:IIntelligence;
    public var sequence:Array;

    public var rodilhos:Sprite;

    public function Machine() {
        super();
        init();
    }

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
     * Cria a máquina, disparado após adicionado ao palco
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
            var l:ItemsList = new ItemsList(data);
            l.x = (MachineConfig.SLOT_WIDTH+MachineConfig.COLUMN_GAP)*i;

            rodilhos.addChild(l)
        }


    }

    protected function provider_loadDataHandler(e:ProviderEvent):void
    {
        createMachine();
    }
}
}
