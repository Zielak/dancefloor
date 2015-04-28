package ;

import luxe.options.VisualOptions;
import luxe.utils.Maths;
import luxe.Vector;

class Human extends Actor
{
    // Static characteristics of a person
    // Intro/Extrovert, Brave/Shy, Peaceful/Aggressive etc.
    // Values usually in range of <0...1>
    public var persona:Map<Persona, Dynamic>;

    // TODO: short-term memory of last events.
    // public var memory:Array<Event>;




    @:isVar public var age          (default, null):Float;
    @:isVar public var sex          (default, null):Sex;
    @:isVar public var orientation  (default, null):Orientation;
    @:isVar public var status       (default, null):Status;

    override public function new( _options:HumanOptions )
    {
        if( _options.geometry == null ){
            var geom = Luxe.draw.box({
                x:0, y:0, w:12, h:30,
            });
            geom.translate(new Vector(-6, -15));
            _options.geometry = geom;
        }
        super(_options);

        age = applyOptional( _options.age, Maths.random_float(18, 35) );
        sex = applyOptional( _options.sex, (Maths.random_int(0,1) == 0) ? Male : Female);
        orientation = applyOptional( _options.orientation, Heterosexual );
        status = applyOptional( _options.status, Single );

    }

    inline function applyOptional<T>(option:T, def:T):T
    {
        if(option == null){
            return def;
        }else{
            return option;
        }
    }

    override function init()
    {

        persona = new Map<Persona, Dynamic>();

        add(new human.Thirst());
        add(new human.Hunger());
        add(new human.Intoxication());


        add(new components.AIController({name: 'controller'}));
        add(new components.InputAI({name: 'input'}));

        add(new components.MoverWalking({}));

        add(new components.Appearance());

    }

    override function update(dt:Float)
    {
        super.update(dt);
        

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

typedef HumanOptions = {
    > VisualOptions,

    @:optional var age:Float;
    @:optional var sex:Sex;
    @:optional var orientation:Orientation;
    @:optional var status:Status;
    @:optional var persona:Persona;
}
