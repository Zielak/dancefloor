package components;

import luxe.Vector;
import luxe.Rectangle;
import luxe.options.ComponentOptions;

class Bounds extends FixedComponent
{
    
    public var bounds:Rectangle;

    override public function new(_options:BoundsOptions)
    {
        super({name:'bounds'});

        type = collider;

        bounds = _options.bounds;
    }

    /**
     * Limit actor's location to bounds
     */
    override public function step(dt:Float)
    {
        if(bounds != null){
            if(actor.realPos.x + actor.velocity.x*dt > bounds.w)
            {
                actor.events.fire('bounds.hit', {normal: new Vector(-1, 0)});
            }
            else if(actor.realPos.x + actor.velocity.x*dt < bounds.x)
            {
                actor.events.fire('bounds.hit', {normal: new Vector(1, 0)});
            }

            if(actor.realPos.y + actor.velocity.y*dt > bounds.h)
            {
                actor.events.fire('bounds.hit', {normal: new Vector(0, -1)});
            }
            else if(actor.realPos.y + actor.velocity.y*dt < bounds.y)
            {
                actor.events.fire('bounds.hit', {normal: new Vector(0, 1)});
            }
        }
    } // applyBounds


}

typedef BoundsOptions = {
    var bounds:Rectangle;
}

typedef BoundsHitEvent = {
    var normal:Vector;
}
