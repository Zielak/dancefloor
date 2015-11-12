package human;

import human.HumanAttribute;
import luxe.options.ComponentOptions;
import luxe.utils.Maths;

using utils.FloatUtil;

class Hunger extends HumanAttribute
{

    override public function new()
    {
        super({name:'hunger'});
    }

    override function init()
    {

        

    }

    override function onadded()
    {
        super.onadded();
        
        value = Main.random.float(0, 0.1);
    }

    override public function step(dt:Float)
    {

        value += dt * 0.001;

        value = value.limit();
    }

}
