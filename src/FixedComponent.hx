package ;

import luxe.options.ComponentOptions;

class FixedComponent extends luxe.Component
{
    
    public var type:FixedComponentType = normal;

    @:isVar public var inited (default, null) :Bool;
    
    var actor:Actor;
    
        // Firex every fixed update.
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

enum FixedComponentType
{
    normal;
    controller;
    mover;
    collider;
    attribute;
}
