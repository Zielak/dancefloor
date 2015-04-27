package components;

import luxe.Vector;
import luxe.Rectangle;

class Mover extends Component
{
    
    // TODO: should be separate component
    public var bounds           :Rectangle;
    
    @:isVar public var inited (default, null) :Bool;



    override function onadded()
    {
        // trace('Mover.onadded() - "${this.name}"');
        super.onadded();

        if(actor == null) {
            throw "Mover belongs on an Actor instance";
        } //Actor test

        Director.physics.add(actor);

        actor.add_mover(this);
    }



    override function onremoved()
    {
        Director.physics.remove(actor);
        actor.remove_mover(this);

        super.onremoved();
    }



    /**
     * Limit actor's location to bounds
     */
    // TODO: Separate component
    function applyBounds()
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
                actor.realPos.y = bounds.x;
            }
        }
    } // applyBounds


}
