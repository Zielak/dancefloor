package ;

import luxe.options.ComponentOptions;

class Component extends luxe.Component
{
    var actor:Actor;
    
    public function step(dt:Float) {}

    override function onadded()
    {
        actor = cast entity;
    }

    override function onremoved()
    {
        actor = null;
    }

}
