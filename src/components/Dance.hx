package components;

import luxe.Color;
import luxe.utils.Maths;
import phoenix.geometry.Vertex;

class Dance extends Component
{

    var speed:Float = 10;
    var mag_x:Float = 4;
    var mag_y:Float = 4;

    var tx:Float = 0;
    var ty:Float = 0;

    var t:Float = 0;

    var verts:Array<Vertex>;
    var move_v:Array<Int>;

    override function onadded()
    {
        super.onadded();

        verts = new Array();
        move_v = [0,1,4];

        for(v in actor.geometry.vertices)
        {
            verts.push( v.clone() );
        }
    }

    override function onremoved()
    {
        for(i in move_v)
        {
            actor.geometry.vertices[i].pos.x = verts[i].pos.x;
            actor.geometry.vertices[i].pos.y = verts[i].pos.y;
        }
    }

    override function update(dt:Float)
    {
        t += dt;

        tx = Math.sin(t*speed) * mag_x;
        ty = Math.sin(t*(speed*2)) * mag_y;

        update_vertices();
    }

    function update_vertices()
    {
        for(i in move_v)
        {
            actor.geometry.vertices[i].pos.x = verts[i].pos.x + tx - mag_x/2;
            actor.geometry.vertices[i].pos.y = verts[i].pos.y + ty - mag_y/2;
        }
    }

}
