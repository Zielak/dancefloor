package components;

import luxe.Input;
import luxe.options.ComponentOptions;
import luxe.Rectangle;

class HumanVisualSelector extends Component
{
    
    var bounds:Rectangle;

    override public function new(_options:ClickableOptions)
    {
        _options.name = 'humanvisualselector';
        super(_options);

        bounds = _options.bounds;
    }

    override function onmousedown(e:MouseEvent)
    {
        if( bounds.point_inside(e.pos) )
        {
            HumanVisual.watch( cast(actor, Human) );
        }
    }

    override function update(dt:Float)
    {
        bounds.x = actor.realPos.x - bounds.w/2;
        bounds.y = actor.realPos.y - bounds.h/2;
    }

}

typedef ClickableOptions = {
    > ComponentOptions,

    var bounds:Rectangle;
}
