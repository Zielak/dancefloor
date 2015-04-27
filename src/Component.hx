package ;

import luxe.options.ComponentOptions;

class Component extends luxe.Component
{
    var actor:Actor;

    override function onadded()
    {
        actor = cast Entity;
    }

}
