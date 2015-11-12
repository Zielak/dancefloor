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
            if(actor.realPos.x > bounds.w){
                actor.realPos.x = bounds.w;
            }else if(actor.realPos.x < bounds.x){
                actor.realPos.x = bounds.x;
            }

            if(actor.realPos.y > bounds.h){
                actor.realPos.y = bounds.h;
            }else if(actor.realPos.y < bounds.y){
                actor.realPos.y = bounds.y;
            }
        }
    } // applyBounds


}

typedef BoundsOptions = {
    var bounds:Rectangle;
}
