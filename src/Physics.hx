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

    var lastTime:Float = 0;
    var trueDelta:Float = 0;
    var difference:Float = 0;

    // how many steps behind are we right now?
    // compensate for the loss when lagging.
    var steps:Int = 0;

    var test:Float = 0;
    // Negative or positive?
    var lastDifferencePositive:Bool = false;

    public override function init()
    {

        actors = new Array<Actor>();

        delayedActions = new Array<Void->Void>();

        gravity = new Vector(0, 0, -9.8);

        Luxe.physics.step_rate = 1/60;
        Luxe.physics.step_delta = 1/60;

    } //init


        //update the actual physics
    public override function update() {

        super.update();

        if(!paused) {

            trueDelta = Luxe.core.current_time - lastTime;
            lastTime = Luxe.core.current_time;
            difference = trueDelta - Luxe.physics.step_delta * Luxe.timescale;


            steps = 1;
            test = (lastDifferencePositive) ? 0 : Luxe.physics.step_delta;
            while(difference > test){
                steps++;
                difference -= Luxe.physics.step_delta;
            }
            lastDifferencePositive = !lastDifferencePositive;

            if(delayedActions.length > 0)
            {
                for(_func in delayedActions)
                {
                    _func();
                }
                delayedActions = new Array<Void->Void>();
            }
            
            // Update ALL THE ACTORS!
            for(i in 0...steps)
            {
                for(_actor in actors)
                {
                    _actor.step(Luxe.physics.step_delta * Luxe.timescale);
                }
            }

        } //paused

    } //update

    public override function destroy() {

        actors = null;

    } //destroy


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
        if(_actor.movers.length <= 1)
        {
            actors.remove(_actor);
        }
    }


        // Delay action for the next physics update
    public function queue(_function:Void -> Void)
    {
        delayedActions.push(_function);
    }
}

