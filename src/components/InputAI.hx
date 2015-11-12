package components;

import components.Bounds;
import luxe.Input;
import luxe.options.ComponentOptions;
import luxe.Vector;


class InputAI extends FixedComponent
{

    @:isVar public var up       (default, null):Bool;
    @:isVar public var down     (default, null):Bool;
    @:isVar public var left     (default, null):Bool;
    @:isVar public var right    (default, null):Bool;

    @:isVar public var dir      (default, null):Int;

    @:isVar public var a        (default, null):Bool;
    @:isVar public var b        (default, null):Bool;

    @:isVar public var angle        (default, null):Float;
    @:isVar public var movePressed  (default, null):Bool;

    var forcedAngle:Float;

    override function init()
    {
        entity.events.listen('move.start', function(e:InputAIEvent){
            if(e.angle != null){
                forcedAngle = e.angle;
                // trace('move.start: ${e}');
            }
        });
        entity.events.listen('move.stop', function(e:InputAIEvent){
            forcedAngle = -1;
        });
        entity.events.listen('bounds.hit', function(e:BoundsHitEvent){
            if(e.normal.x > 0){
                forcedAngle = 0;
            }
            if(e.normal.x < 0){
                forcedAngle = 180;
            }

            if(e.normal.y > 0){
                forcedAngle = 90;
            }
            if(e.normal.y < 0){
                forcedAngle = 270;
            }
        });

        angle = 0;
        forcedAngle = -1;

    }

    override public function step(dt:Float)
    {
        if(forcedAngle == -1) {
            updateKeys();
        } else {
            movePressed = true;
            angle = forcedAngle;
        }
    }


    function updateKeys():Void
    {
        if( up && down )
        {
            up = down = false;
        }
        if( left && right )
        {
            left = right = false;
        }

        movePressed = false;

        if( up || down || left || right )
        {
            movePressed = true;

            if ( up )
            {
                angle = Math.PI*3 / 2;//-90;
                if ( left)
                    angle -= Math.PI/4;
                else if ( right)
                    angle += Math.PI/4;
            }
            else if ( down )
            {
                angle = Math.PI/2;//90;
                if ( left )
                    angle += Math.PI/4;
                else if ( right )
                    angle -= Math.PI/4;
            }
            else if ( left )
                angle = Math.PI;
            else if ( right )
                angle = 0;
        }

    }

}


enum ActionEnum {
    ActionA;
    ActionB;
    ActionC;
}

typedef InputAIEvent = {

    // Direction towards which character should be moving
    @:optional var angle:Float;

    // Optionally, we accept dpad-style 8dir, if angle isn't used
    @:optional var dir:Int;

    // Which action should I press?
    @:optional var action:ActionEnum;
}
