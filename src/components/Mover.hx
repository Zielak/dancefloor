package components;

import luxe.Vector;
import luxe.Rectangle;

class Mover extends Component
{
    
    @:isVar public var inited (default, null) :Bool;



    override function onadded()
    {
        super.onadded();

        if(actor == null) {
            throw "Mover belongs on an Actor instance";
        } //Actor test

        Main.physics.add(actor);

        actor.add_mover(this);
    }



    override function onremoved()
    {
        Main.physics.remove(actor);
        actor.remove_mover(this);

        super.onremoved();
    }

}
