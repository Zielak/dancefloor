package human;

import human.Property;
import luxe.options.ComponentOptions;
import luxe.utils.Maths;

using utils.FloatUtil;

class Thirst extends Property
{

    override public function new()
    {
        super({name:'thirst'});
    }

    override function init()
    {

        

    }

    override function onadded()
    {
        super.onadded();
        
        value = Main.random.float(0, 0.2);
    }

    override public function step(dt:Float)
    {

        value += dt * 0.013;

        value = value.limit();
    }

}
