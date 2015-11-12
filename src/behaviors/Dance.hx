package behaviors;

import hxbt.Behavior;


class Dance extends Behavior
{
    var actor:Actor;

    var time:Float = 5;
    var randomizeTime:Float = 0;

    var _counter:Float;

    override public function new(options:DanceOptions)
    {
        super();

        name = 'D';

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

        actor.add(new components.Dance({name:'dance'}));
    }

    override public function onTerminate(context:AIContext, status:Status)
    {
        actor.remove('dance');
    }

    override public  function update(_, dt:Float)
    {
        _counter -= dt;

        if(_counter <= 0) return Status.SUCCESS;
        return Status.RUNNING;
    }

}

typedef DanceOptions = {
    var time:Float;
    @:optional var randomizeTime:Float;
}

