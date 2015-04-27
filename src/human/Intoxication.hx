package human;

import luxe.options.ComponentOptions;

class Intoxication extends Component
{

    var value:Float;

    override function new(_options:ComponentOptions)
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
        value = 0;
    }

    override function update(dt:Float)
    {

        value -= dt * 0.0011;

    }




    function ondrink(_)
    {

    }
    
    function ondrug(_)
    {

    }

}
