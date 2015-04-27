package human;

import luxe.options.ComponentOptions;

class Thirst extends Components
{

    var value:Float;

    override function new(_options:ComponentOptions)
    {
        super({name:'thirst'});
    }

    override function init()
    {

        

    }

    override function onadded()
    {
        value = 0;
    }

    override function update(dt:Float)
    {

        value += dt * 0.00013;

    }

}
