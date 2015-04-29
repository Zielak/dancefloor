package human;

import luxe.options.ComponentOptions;
import luxe.utils.Maths;

using utils.FloatUtil;

class Hunger extends Component
{

    @:isVar public var value(default, null):Float;

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
        
        value = Maths.random_float(0, 0.1);
    }

    override function update(dt:Float)
    {

        value += dt * 0.001;

        value = value.limit();
    }

}
