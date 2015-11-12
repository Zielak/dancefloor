package behaviors;

import hxbt.Behavior.Status;

class CheckAttributeHunger extends CheckAttribute
{

    override public function new()
    {
        super();
        name = 'H';

        attr_name = 'hunger';
    }

    override function calculate()
    {
        // Is very hungry
        if(attr.value > Main.random.float(0.5, 0.7) ){
            // Keep on digging this sequence I guess?
            return Status.SUCCESS;
        }else{
            // Get out, find other things to do
            return Status.INVALID;
        }
    }

}

