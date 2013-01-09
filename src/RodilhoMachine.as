package {

import flash.display.Graphics;
import flash.display.Sprite
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.EventDispatcher;

import rodilho.Machine;
import rodilho.events.ProviderEvent;
import rodilho.intelligence.DefaultIntelligence;
import rodilho.provider.EmbededProvider;

import rodilho.provider.IDataProvider;

import util.Console;

public class RodilhoMachine extends Sprite {

    public var machine:Machine;

    public var console:Console;

    public function RodilhoMachine()
    {
        super();
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        init();
    }

    public function init():void
    {
        console = new Console();
        addChild(console);

        machine = new Machine();

        machine.provider = new EmbededProvider();
        machine.intelligence = new DefaultIntelligence();

        machine.sequence = [
            ["A", "B", "C", "D", "E", "F"],
            ["B", "B", "A", "F", "E", "A"],
            ["C", "A", "F", "F", "A", "A"],
            ["A", "A", "A", "B", "B", "A"],
            ["F", "A", "C", "C", "C", "A"]
        ]
        machine.run();
        addChild(machine);



    }

}
}
