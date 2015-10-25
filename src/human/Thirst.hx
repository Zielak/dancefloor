package human;

import luxe.options.ComponentOptions;
import luxe.utils.Maths;

using utils.FloatUtil;

class Thirst extends Component
{

    @:isVar public var value(default, null):Float;

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

    override function update(dt:Float)
    {

        value += dt * 0.013;

        value = value.limit();
    }

}
