package ;

import luxe.options.VisualOptions;
import luxe.utils.Maths;

class Human extends Actor
{
    // Static characteristics of a person
    // Intro/Extrovert, Brave/Shy, Peaceful/Aggressive etc.
    // Values usually in range of <0...1>
    public var persona:Map<Persona, Dynamic>;

    // TODO: short-term memory of last events.
    // public var memory:Array<Event>;




    @:isVar public var age          (get, null):Float;
    @:isVar public var sex          (get, null):Sex;
    @:isVar public var orientation  (get, null):Orientation;
    @:isVar public var status       (get, null):Status;

    override public function new( _options:VisualOptions )
    {
        super(_options);

        age = Maths.random_float(18, 35);
        sex = ( Maths.random_int(0,1) == 0 ) ? Male : Female;
        orientation = Heterosexual;
        status = Single;

    }

    override function init()
    {

        persona = new Map<Persona, Dynamic>();

        add(new human.Thirst());
        add(new human.Hunger());
        add(new human.Intoxication());


        add(new components.Appearance());

    }

    override function update(dt:Float)
    {

        

    }

}


enum Sex {
    Male;
    Female;
}

enum Orientation {
    Heterosexual;
    Homosexual;
    Bisexual;
}

enum Status {
    Engaged;
    Single;
}

enum Persona {
    IntroExtroVert;
    BraveShy;
    PeacefulAggressive;
}
