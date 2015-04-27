package behaviors;

import hxbt.Behavior;


class Wait extends Behavior
{
    var time:Float = 5;
    var randomizeTime:Float = 0;

    var _counter:Float;

    override public function new(options:WaitOptions)
    {
        super();

        if(Reflect.hasField(options, 'time')){
            time = options.time;
        }

        if(Reflect.hasField(options, 'randomizeTime')){
            randomizeTime = options.randomizeTime;
        }
    }

    override public function onInitialize(_)
    {
        _counter = time + (Math.random()-0.5)*randomizeTime;
    }

    override public  function update(_, dt:Float)
    {
        _counter -= dt;

        if(_counter <= 0) return Status.SUCCESS;
        return Status.RUNNING;
    }

}

typedef WaitOptions = {
    var time:Float;
    @:optional var randomizeTime:Float;
}

