package behaviors;

import hxbt.Behavior;
import behaviors.AIContext;


class MoveToArea extends Behavior
{
    var actor:Actor;

    var target_area_name:String;
    var target_area:Area;

    var angle:Float;
    var _counter:Float;

    override public function new(options:MoveToAreaOptions)
    {
        super();

        name = 'mA';

        target_area_name = options.target_area_name;
    }

    override public function onInitialize(context:AIContext)
    {
        actor = context.actor;

        // Pick random area?
        var arr = Main.areas_scene.entities;
        target_area = arr[Main.random.int(0,arr.length)];

        actor.events.fire('move.to.area', {area: target_area} );
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

typedef MoveToAreaOptions = {

    var target_area_name:String;

    // var time:Float;
    // @:optional var randomizeTime:Float;
}
