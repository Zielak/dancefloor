package human;

import luxe.options.ComponentOptions;

class Hunger extends Component
{

    var value:Float;

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
        
        value = 0;
    }

    override function update(dt:Float)
    {

        value += dt * 0.0001;

    }

}
