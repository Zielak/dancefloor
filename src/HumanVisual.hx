package ;

import hxbt.Behavior;
import hxbt.BehaviorTree;
import hxbt.Composite;
import luxe.Camera;
import luxe.Color;
import luxe.options.TextOptions;
import luxe.options.VisualOptions;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import luxe.Visual;
import phoenix.Batcher;

class HumanVisual
{

    public static inline var C_BG:Int = 0x000000;
    public static inline var C_TEXT:Int = 0xAAAAAA;

    public static inline var POINT_SIZE:Float = 10;

    public static inline var TEXT_W:Float = 150;
    public static inline var TEXT_H:Float = 14;

    public static inline var PADDING:Float = 3;

    // obserwed human
    static var guy:Human;

    static var batcher:Batcher;
    static var camera:Camera;

    static var text:Text;
    static var string:String;

    static var fields:Array<HVField>;
    static var bg:Visual;

    static var inited:Bool = false;

    public static function init()
    {
        inited = true;

        camera = new Camera({ name : 'humanvisualcamera' });
        batcher = Luxe.renderer.create_batcher({
            name:'humanvisualviewport',
            camera:camera.view
        });
        batcher.layer = 9;

        // bg = new Visual({
        //     pos: new Vector(0,0),
        //     size: new Vector(TEXT_W,TEXT_H),
        //     color: new Color().rgb(C_BG),
        //     batcher: batcher,
        // });

        text = new Text({
            bounds: new Rectangle(PADDING, PADDING, TEXT_W - PADDING*2, TEXT_H - PADDING*2),
            point_size: POINT_SIZE,
            color: new Color().rgb(C_TEXT),
            batcher: batcher,
            text: 'Loading',
        });
    }

    public static function watch(_guy:Human)
    {
        if(!inited) init();

        guy = cast _guy;
        fields = new Array<HVField>();

        fields.push(new HVField({
            label: 'Name: ',
            value: function(){return guy.realname;},
        }));
        fields.push(new HVField({
            label: 'Age: ',
            value: function(){
                return Std.string( Math.round(guy.age*10)/10 );
            },
        }));
        fields.push(new HVField({
            label: 'Sex: ',
            value: function(){return guy.sex.getName();},
        }));

        if(guy.has('hunger'))
        fields.push(new HVField({
            label: '- Hunger: ',
            value: function(){
                return Std.string( Math.round(guy.get('hunger').value*100)/100 );
            },
        }));

        if(guy.has('thirst'))
        fields.push(new HVField({
            label: '- Thirst: ',
            value: function(){
                return Std.string( Math.round(guy.get('thirst').value*100)/100 );
            },
        }));

        if(guy.has('intoxication'))
        fields.push(new HVField({
            label: '- Intox.: ',
            value: function(){
                return Std.string( Math.round(guy.get('intoxication').value*100)/100 );
            },
        }));

        Luxe.timer.schedule(1/30, function(){
            refresh();
        }, true);
    }

    static function refresh()
    {
        string = "";

        for(_f in fields)
        {
            string += _f.update();
            string += "\n";
        }

        text.text = string;
    }

}

class HVField
{

    var value:Void->String;
    var label:String;

    public function new(_options:HVTextFieldOptions)
    {
        value = _options.value;
        label = _options.label;
    }

    public function update()
    {
        return label + value();
    }

}

typedef HVTextFieldOptions = {
    var label:String;
    var value:Void->String;
}
