package components;

import luxe.Color;
import luxe.options.ComponentOptions;
import luxe.utils.Maths;
import phoenix.geometry.Vertex;

class Dance extends FixedComponent
{
    var dance_type:Int;

    var speed:Float;
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

        // Match my moves when you start dancing
        // TODO: offset
        speed = 1/Luxe.physics.step_delta * 60 / Main.BPM / 4; // 4 bangers
        // ^- http://www.peachpit.com/articles/article.aspx?p=22799

        dance_type = Main.random.int(3);

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

    override public function step(dt:Float)
    {
        t += dt;

        switch (dance_type) {
            case 0:
                tx = Math.sin(t*speed) * mag_x;
                ty = Math.sin(t*(speed*2)) * mag_y;
            case 1:
                tx = mag_x/2;
                ty = Math.sin(t*speed*2) * mag_y;
            case 2:
                tx = Math.sin(t*speed*2) * mag_x;
                ty = mag_y/2;

        }

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
