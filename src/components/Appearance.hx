package components;

import luxe.Color;
import luxe.utils.Maths;

class Appearance extends Component
{

    var colors:Array<Color>;

    override function onadded()
    {
        super.onadded();

        colors = new Array<Color>();

        var h:Float = Maths.random_float(0,360);
        var s:Float = Maths.random_float(0.5, 1);
        var l:Float = Maths.random_float(0.5, 1);

        for( i in 0...4 )
        {
            colors.push( new Color().fromColorHSL( new ColorHSL(h,s,l) ) );
            h += 10;
        }

        actor.geometry.vertices[0].color = colors[0];
        actor.geometry.vertices[1].color = colors[1];
        actor.geometry.vertices[2].color = colors[2];
        actor.geometry.vertices[3].color = colors[3];
        actor.geometry.vertices[4].color = colors[0];
        actor.geometry.vertices[5].color = colors[2];
        
    }

}
