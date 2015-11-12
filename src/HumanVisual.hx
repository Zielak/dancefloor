package ;

import hxbt.Behavior;
import hxbt.BehaviorTree;
import hxbt.Composite;
import luxe.Camera;
import luxe.Color;
import luxe.Entity;
import luxe.options.TextOptions;
import luxe.options.VisualOptions;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import luxe.Visual;
import phoenix.Batcher;

class HumanVisual extends Entity
{

    public static inline var C_BG:Int = 0x000000;
    public static inline var C_TEXT:Int = 0xAAAAAA;

    public static inline var POINT_SIZE:Float = 14;

    public static inline var TEXT_W:Float = 150;
    public static inline var TEXT_H:Float = 150;

    public static inline var PADDING:Float = 3;

    // obserwed human
    var guy:Human;

    var batcher:Batcher;
    var camera:Camera;

    var text:Text;
    var string:String;

    var fields:Array<HVField>;
    var bg:Visual;

    var indicator:Visual;

    override public function init()
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

        indicator = new Visual({
            pos: new Vector(0,0),
            geometry: Luxe.draw.ngon({
                sides: 3, r: 7,
                angle: 60,
                x:0, y:-25,
                solid: true,
            }),
            color: new Color(1,0.2,0),
            depth: 101,
        });

        text = new Text({
            bounds: new Rectangle(PADDING, PADDING, TEXT_W - PADDING*2, TEXT_H - PADDING*2),
            point_size: POINT_SIZE,
            color: new Color().rgb(C_TEXT),
            batcher: batcher,
            text: 'HumanVisual',
            parent: this,
        });

        Luxe.events.listen('human.watch', function(e:HumanVisualEvent){
            watch(e.human);
        });
    }

    function watch(_guy:Human)
    {
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

        if(guy.has('attr_hunger'))
            fields.push(new HVField({
                label: '- Hunger: ',
                value: function(){
                    return Std.string( Math.round(guy.get('attr_hunger').value*100)/100 );
                },
            }));

        if(guy.has('attr_thirst'))
            fields.push(new HVField({
                label: '- Thirst: ',
                value: function(){
                    return Std.string( Math.round(guy.get('attr_thirst').value*100)/100 );
                },
            }));

        if(guy.has('attr_intoxication'))
            fields.push(new HVField({
                label: '- Intox.: ',
                value: function(){
                    return Std.string( Math.round(guy.get('attr_intoxication').value*100)/100 );
                },
            }));

        Luxe.timer.schedule(1/30, function(){
            refresh();
        }, true);
    }

    override function update(dt:Float)
    {
        if(guy != null){
            indicator.pos.copy_from( guy.pos.clone() );
        }
    }

    function refresh()
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

typedef HumanVisualEvent = {
    var human:Human;
}
