package components;

import luxe.options.ComponentOptions;

class MoverWalking extends FixedComponent{

        // speeds
    public var maxWalkSpeed:Float = 110;
    var accel_rate:Float = 5;
    var decel_rate:Float = 25;

    var _speed:Float = 0;
    var _angle:Float = 0;

    override public function new(?_options:MoverWalkingOptions)
    {
        super(_options);

        type = mover;

        if(_options.maxWalkSpeed != null){
            maxWalkSpeed = _options.maxWalkSpeed;
        }

    }

    

    override function init()
    {
        entity.events.listen('startDancing', function(_){
            this.maxWalkSpeed = 3;
        });
    }

    override public function step(dt:Float)
    {
        if(has('input'))
        {
            setSpeed(dt);
            setAngle(dt);
        }

        actor.velocity.set_xy(_speed, 0);
        if(_angle != -1 && _speed > 0) actor.velocity.angle2D = _angle;
        
    }

    function setSpeed(dt:Float):Void
    {
        if( get('input').movePressed )
        {
            if( _speed < maxWalkSpeed ){
                _speed += maxWalkSpeed * accel_rate * dt;
            }
            if( _speed > maxWalkSpeed ){
                _speed = maxWalkSpeed;
            }
        }
        else
        {
            if( _speed >= 1){
                _speed -= _speed * decel_rate * dt;
            }
            if( _speed < 1 ){
                _speed = 0;
            }
        }
    } // setSpeed


    function setAngle(dt:Float)
    {
        _angle = get('input').angle;
    }
}

typedef MoverWalkingOptions = {
    > ComponentOptions,

    @:optional var maxWalkSpeed:Float;
}
