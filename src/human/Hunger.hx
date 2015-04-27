package human;

import luxe.options.ComponentOptions;

class Hunger extends Component
{

    var value:Float;

    override function new(_options:ComponentOptions)
    {
        super({name:'hunger'});
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

        value += dt * 0.0001;

    }

}
