package ;

import luxe.Color;
import luxe.Entity;
import luxe.options.EntityOptions;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Visual;

class Area extends Entity
{
    @:isVar public var bounds   (default, null):Rectangle;



// Drawing visual region
    
    var v_rect:Visual;


    override public function new( _options:AreaOptions )
    {
        super(_options);

        bounds = _options.bounds;

        draw_area(_options);
    }

    function draw_area(_options)
    {
        v_rect = new Visual({
            pos: new Vector(bounds.x, bounds.y),
            geometry: Luxe.draw.box({
                x:0, y:0,
                w: bounds.w,
                h: bounds.h,
            }),
            color: (_options.color != null) ? _options.color : new Color(0,0,0),
        });
    }


}



typedef AreaOptions = {
    > EntityOptions,

    var bounds:Rectangle;

    @:optional var color:Color;
}
