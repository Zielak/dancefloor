package ;

import luxe.options.VisualOptions;
import luxe.Rectangle;
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

    var width:Float;
    var height:Float;

    @:isVar public var realname     (default, null):String;
    @:isVar public var age          (default, null):Float;
    @:isVar public var sex          (default, null):Sex;
    @:isVar public var orientation  (default, null):Orientation;
    @:isVar public var status       (default, null):Status;

    var human_properties:Array<human.Property>;

    override public function new( _options:HumanOptions )
    {
        width = 12;
        height = 30;

        human_properties = new Array<human.Property>();

        if( _options.geometry == null ){
            var geom = Luxe.draw.box({
                x:0, y:0, w:width, h:height,
            });
            geom.translate(new Vector(-6, -15));
            _options.geometry = geom;
        }
        super(_options);

        realname = applyOptional( _options.realname, 'Dummie');
        age = applyOptional( _options.age, Main.random.float(18, 35) );
        sex = applyOptional( _options.sex, (Main.random.int(0,1) == 0) ? Male : Female);
        orientation = applyOptional( _options.orientation, Heterosexual );
        status = applyOptional( _options.status, Single );

        if(_options.persona == null){
            persona = new Map<Persona, Dynamic>();
            persona.set(IntroExtroVert, Math.random());
            persona.set(BraveShy, Math.random());
            persona.set(PeacefulAggressive, Math.random());
        }
    }

    inline function applyOptional<T>(option:T, def:T):T
    {
        if(option == null){
            return def;
        }else{
            return option;
        }
    }

    /**
     * Tries to add human property component
     * @param id Components ID
     * @return  false if already exists, true if added
     */
    public function add_humanproperty(property:human.Property):Bool
    {
        // check if already in
        var found:Int = human_properties.indexOf(property);

        if(found != -1)
        {
            return false;
        }
        else
        {
            human_properties.push(property);
            return true;
        }
    }

    public function remove_humanproperty(property:human.Property):Bool
    {
        // check if already in
        var found:Int = human_properties.indexOf(property);

        if(found != -1)
        {
            human_properties.splice(found, 1);
            return true;
        }
        else
        {
            return false;
        }
    }

    override function init()
    {

        super.init();

        persona = new Map<Persona, Dynamic>();

        add_humanproperty(new human.Thirst());
        add_humanproperty(new human.Hunger());
        add_humanproperty(new human.Intoxication());


        add(new components.AIController({name: 'controller'}));
        add(new components.InputAI({name: 'input'}));

        add(new components.MoverWalking({}));

        add(new components.Appearance());


        // Debugging

        add(new components.HumanVisualSelector({bounds: new Rectangle(0,0,width, height)}));
    }

    override public function step(dt:Float)
    {
        super.step(dt);

        stepComponents(dt, property);
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

    @:optional var realname:String;
    @:optional var age:Float;
    @:optional var sex:Sex;
    @:optional var orientation:Orientation;
    @:optional var status:Status;
    @:optional var persona:Persona;
}
