package {

import flash.display.Sprite
import flash.events.EventDispatcher;

import rodilho.Machine;
import rodilho.events.ProviderEvent;
import rodilho.intelligence.DefaultIntelligence;
import rodilho.provider.EmbededProvider;

import rodilho.provider.IDataProvider;

public class RodilhoMachine extends Sprite {

    public var machine:Machine

    public function RodilhoMachine()
    {
        init();
    }
    public function init():void {
        machine = new Machine();

        machine.provider = new EmbededProvider();
        machine.intelligence = new DefaultIntelligence();
        addChild(machine);

        machine.render();

    }

}
}
