package human;

import human.Property;
import luxe.options.ComponentOptions;
import luxe.utils.Maths;

using utils.FloatUtil;

class Intoxication extends Property
{

    override public function new()
    {
        super({name:'intoxication'});
    }

    override function init()
    {

        actor.events.listen('human.drink.*', ondrink);
        actor.events.listen('human.drug.*', ondrug);

    }

    override function onadded()
    {
        super.onadded();
        
        value = Main.random.float(0, 0.2);
    }

    override public function step(dt:Float)
    {

        value -= dt * 0.011;

        value = value.limit();
    }




    function ondrink(_)
    {

    }
    
    function ondrug(_)
    {

    }

}
