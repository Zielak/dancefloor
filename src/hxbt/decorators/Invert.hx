package hxbt.decorators;

import hxbt.Behavior.Status;
import hxbt.Decorator;

/**
 * Returns success if the child returns failure,
 * returns failure if the child returns success,
 * otherwise returns what the child returns
 * @author Kenton Hamaluik
 */
class Invert extends Decorator
{
	public function new(?child : Behavior) 
	{
		super(child);
	}
	
	override function update(context : Dynamic, dt : Float) : Status
	{
		if(m_child == null)
		{
			throw "Inverter requires child to not be null!";
		}

		var childResult : Status = m_child.tick(context, dt);
		if(childResult == Status.SUCCESS)
		{
			return Status.FAILURE;
		}
		else if(childResult == Status.FAILURE)
		{
			return Status.SUCCESS;
		}
		return childResult;
	}
}