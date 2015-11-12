package behaviors;

import hxbt.Behavior;
import human.HumanAttribute;

class CheckAttribute extends Behavior
{
    var actor:Actor;
    var attr:HumanAttribute;

    var attr_name:String;

    override public function onInitialize(context:AIContext)
    {
        super.onInitialize(context);

        // trace('CheckAttr ${attr_name} INIT');
        actor = context.actor;
    }

    override public function update(context:AIContext, dt:Float)
    {
        super.update(context, dt);

        get_attribute();
        return calculate();
    }

    function get_attribute()
    {
        if(actor.has('attr_'+attr_name)){
            attr = actor.get('attr_'+attr_name);
        }
    }

    function calculate()
    {
        return Status.RUNNING;
    }

}

