package human;

import luxe.options.ComponentOptions;

class Property extends FixedComponent
{

    @:isVar public var value(default, null):Float;

    override public function new( _options:ComponentOptions )
    {
        _options.name = 'prop_'+_options.name;
        super(_options);
    }

    // override function init()
    // {

    // }

    // override function onadded()
    // {
    //     super.onadded();

    //     human = cast actor;

    //     if(human == null) {
    //         throw "Property belongs on a Human instance";
    //     } //Human test
    // }


    // override public function step(dt:Float)
    // {

    // }

}
