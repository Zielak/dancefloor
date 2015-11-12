package human;

import luxe.options.ComponentOptions;

class HumanAttribute extends FixedComponent
{

    @:isVar public var value(default, null):Float;

    override public function new( _options:ComponentOptions )
    {
        type = attribute;

        _options.name = 'attr_'+_options.name;
        super(_options);
    }


}
