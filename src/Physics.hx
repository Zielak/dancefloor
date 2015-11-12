package ;

/**
 * NEEDS CLEANUP
 */

import luxe.Physics;
import luxe.Vector;
import luxe.Scene;

class Physics extends PhysicsEngine
{

        // Holds actors, preferabely with mover components
    public var actors:Array<Actor>;

    var delayedActions:Array<Void->Void>;

    var currentTime:Float = 0;
    var newTime:Float = 0;
    var frameTime:Float = 0;
    var accumulator:Float = 0;

    var test:Float = 0;
    // Negative or positive?
    var lastDifferencePositive:Bool = false;

    public override function new()
    {
        super();

        actors = new Array<Actor>();

        delayedActions = new Array<Void->Void>();

        gravity = new Vector(0, 0, -9.8);

        Luxe.physics.step_rate = 1/60;
        Luxe.physics.step_delta = 1/60;

    } //init


        //update the actual physics
    public override function update()
    {

        super.update();


        newTime = Luxe.core.current_time;
        frameTime = newTime - currentTime;
        currentTime = newTime;

        accumulator += frameTime;
        
        
        if(paused) return;
        
        // Update ALL THE ACTORS!
        while ( accumulator >= Luxe.physics.step_delta )
        {
            step( Luxe.physics.step_delta );
            accumulator -= Luxe.physics.step_delta;
        }

    } //update

    public override function destroy() {

        actors = null;

    } //destroy


    public function pause()
    {
        
        if(paused)
        {
            accumulator = 0;
            paused = false;
        }
        else
        {
            paused = true;
        }

    } // pause

    public function forceStep()
    {
        accumulator = 0;
        step( Luxe.physics.step_delta );
    }


        // Add an actor to the process
    public function add( _actor:Actor )
    {
        var exists:Bool = false;

        for(_a in actors)
        {
            if(_a.id == _actor.id){
                exists = true;
                break;
            }
        }

        if(!exists)
        {
            actors.push(_actor);
        }
    }

        // Remove an actor from the process
    public function remove( _actor:Actor )
    {
        // Remove only if actor currently has only 1 component
        if(_actor.getComponents().length <= 1)
        {
            actors.remove(_actor);
        }
    }


        // Delay action for the next physics update
    public function queue(_function:Void -> Void)
    {
        delayedActions.push(_function);
    }





    function step(dt:Float)
    {

        for(_actor in actors){
            _actor.step(dt);
        }

    }



}

