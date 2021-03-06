package ;

import FixedComponent.FixedComponentType;
import luxe.options.VisualOptions;
import luxe.Visual;
import luxe.Color;
import luxe.Vector;

using utils.VectorUtil;

class Actor extends Visual
{

        // Direction-aware velocity
    public var velocity         :Vector;

        // constant addition
    public var acceleration     :Vector;

        // Force is reset each frame.
        // Should be used to apply impulse forces, like jump.
    public var force            :Vector;

        // gets data from/to velocity
    public var speed(get, set)  :Float;

        // Real position of Actor, right before it's rounded for view
    public var realPos          :Vector;


        // Stores components of Fixed components
    @:isVar public var fixed_components (default, null):Array<FixedComponent>;

    // move geometry by z position
    var _zoffset:Vector;
    // current posision of geometry
    var _current_geom:Vector;
    var _lowest:Vector;

    override public function new(_options:VisualOptions)
    {
        realPos = _options.pos;

        super(_options);

        fixed_components = new Array<FixedComponent>();

        _zoffset        = new Vector();
        _current_geom   = new Vector();
        _lowest         = new Vector();

        velocity        = new Vector();
        acceleration    = Main.physics.gravity;
        force           = new Vector();
    }

    override function init():Void
    {
        realPos.copy_from(pos);

        // lastPos = new Vector();
        // lastPos.copy_from(realPos);

        _lowest = verticesGetBottomVector(geometry.vertices);

        Main.physics.add(this);
    }

    override function ondestroy():Void
    {
        Main.physics.remove(this);

        realPos = null;
        _zoffset = null;
        _current_geom = null;
    }

    override function update(dt:Float):Void
    {
        pos.copy_from(realPos);

        pos.x = Math.round(pos.x);
        pos.y = Math.round(pos.y);
        pos.z = Math.round(pos.z);

        depth = realPos.y/1000;

        updateGeometryHeight();
    }


    public function applyForce(_x:Float, _y:Float, ?_z:Float = 0):Void
    {
        force.x += _x;
        force.y += _y;
        force.z += _z;
    } // applyForce


    // Calls step() on every mover type component and collider
    public function step(dt:Float)
    {

        // Luxe.events.fire('hud.physics.add', {s:'Actor.step(${Math.round(dt*10000)/10000})'});

        stepComponents(dt, controller);
        stepComponents(dt, mover);
        stepComponents(dt, collider);

        velocity.add(force);
        velocity.add(acceleration);

        // Clean vectors
        if( Math.abs(velocity.x) < 0.1 && velocity.x!= 0 ) velocity.x = 0;
        if( Math.abs(velocity.y) < 0.1 && velocity.y!= 0 ) velocity.y = 0;
        if( Math.abs(velocity.z) < 0.1 && velocity.z!= 0 ) velocity.z = 0;

        // Limit floor
        if( velocity.z < 0 && realPos.z+velocity.z*dt < 0){
            velocity.z = -realPos.z/dt;
        }

        realPos.x += velocity.x * dt;
        realPos.y += velocity.y * dt;
        realPos.z += velocity.z * dt;


        force.set_xyz(0,0,0);


        stepComponents(dt, normal);

    }



    public function get_speed():Float
    {
        return velocity.get_length2D();
    }
    public function set_speed(v:Float):Float
    {
        velocity.set_length2D(v);
        return velocity.get_length2D();
    }


    /**
     * Tries to add component
     * @param id Components ID
     * @return  false if already exists, true if added
     */
    // public function add_mover(mover:Mover):Bool
    // {
    //     // check if already in
    //     var found:Int = movers.indexOf(mover);

    //     if(found != -1)
    //     {
    //         return false;
    //     }
    //     else
    //     {
    //         movers.push(mover);
    //         return true;
    //     }
    // }

    // public function remove_mover(mover:Mover):Bool
    // {
    //     // check if already in
    //     var found:Int = movers.indexOf(mover);

    //     if(found != -1)
    //     {
    //         movers.splice(found, 1);
    //         return true;
    //     }
    //     else
    //     {
    //         return false;
    //     }
    // }


    // Step all time fixed components by type
    public function stepComponents(dt:Float, ?type:FixedComponentType)
    {
        if( type == null ){
            type = FixedComponentType.normal;
        }

        var _fcomp:FixedComponent;
        for(_comp in this.components)
        {
            _fcomp = cast( _comp, FixedComponent );
            if( _fcomp != null )
            {
                // Check for type
                if(_fcomp.type == type){
                    _fcomp.step(dt);
                }
            }
        }
    }

    // Get all time fixed components or of given type
    public function getComponents(?type:FixedComponentType):Array<FixedComponent>
    {
        var _fcomp:FixedComponent;
        var _fcomps:Array<FixedComponent> = new Array<FixedComponent>();

        for(_comp in this.components)
        {
            _fcomp = cast( _comp, FixedComponent );
            if( _fcomp != null )
            {
                // Check for type
                if(_fcomp.type == type && type != null || type == null){
                    _fcomps.push(_fcomp);
                }
            }
        }

        return _fcomps;
    }


    // function stepMovers(dt:Float)
    // {
    //     for(_mover in movers)
    //     {
    //         _mover.step(dt);
    //     }
    // }

    // function stepColliders(dt:Float)
    // {
    //     if(has('collider'))
    //     {
    //         get('collider').step(dt);
    //     }
    // }




    function updateGeometryHeight()
    {
        _zoffset.y = -pos.z - _current_geom.y;
        _current_geom.y += _zoffset.y;
        geometry.translate(_zoffset);
    }


    function verticesGetBottomVector(arr:Array<phoenix.geometry.Vertex>):Vector
    {
        // The higher value, the lower it's displayed
        var bot:Vector = new Vector(0,-500);
        for(v in arr)
        {
            if(v.pos.y > bot.y) bot.copy_from(v.pos);
        }
        return bot;
    }

}
