package human;

import luxe.options.ComponentOptions;

class Thirst extends Component
{

    var value:Float;

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
        
        value = 0;
    }

    override function update(dt:Float)
    {

        value += dt * 0.00013;

    }

}
