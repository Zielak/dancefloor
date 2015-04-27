package behaviors;

import hxbt.Behavior;
import behaviors.AIContext;


class MoveInRandomDirection extends Behavior
{
    var actor:Actor;

    var time:Float = 5;
    var randomizeTime:Float = 0;

    var angle:Float;
    var _counter:Float;

    override public function new(options:MoveInDirectionOptions)
    {
        super();

        if(Reflect.hasField(options, 'time')){
            time = options.time;
        }

        if(Reflect.hasField(options, 'randomizeTime')){
            randomizeTime = options.randomizeTime;
        }
    }

    override public function onInitialize(context:AIContext)
    {
        actor = context.actor;

        _counter = time + (Math.random()-0.5)*randomizeTime;

        angle = Math.random()*360;

        actor.events.fire('move.start', {angle: angle} );
    }

    override public function onTerminate(context:AIContext, status:Status)
    {
        actor.events.fire('move.stop');
    }

    override public function update(_, dt:Float)
    {
        _counter -= dt;
        if(_counter <= 0) return Status.SUCCESS;
        return Status.RUNNING;
    }

}

typedef MoveInDirectionOptions = {
    var time:Float;
    @:optional var randomizeTime:Float;
}
