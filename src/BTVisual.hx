package ;

import components.AIController;
import hxbt.Behavior;
import hxbt.BehaviorTree;
import hxbt.Composite;
import luxe.Camera;
import luxe.Color;
import luxe.Entity;
import luxe.options.VisualOptions;
import luxe.Vector;
import luxe.Visual;
import phoenix.Batcher;
import HumanVisual;

class BTVisual extends Entity
{

    public static inline var C_INVALID:Int = 0x000000;
    public static inline var C_SUCCESS:Int = 0x33AA33;
    public static inline var C_FAILURE:Int = 0xAA3333;
    public static inline var C_RUNNING:Int = 0x3333AA;

    public static inline var PADDING_X:Float = 5;
    public static inline var PADDING_Y:Float = 5;

    public static inline var NODE_W:Float = 10;
    public static inline var NODE_H:Float = 10;

    var root:Composite;

    // static var batcher:Batcher;
    // static var camera:Camera;

    override function init()
    {
        // camera = new Camera({ name : 'btcamera' });
        // batcher = Luxe.renderer.create_batcher({
        //     name:'btviewport',
        //     camera:camera.view
        // });
        // batcher.layer = 100;

        Luxe.events.listen('human.watch', function(e:HumanVisualEvent){
            var ctrl:AIController = cast e.human.get('controller');
            if(ctrl != null)
            {
                watch(ctrl.m_tree);
            }
        });
    }

    function watch(behavior_tree:BehaviorTree)
    {
        root = cast behavior_tree.root;

        refresh();
    }

    function refresh()
    {
        var _x:Float;
        for(i in 0...root.m_children.length)
        {
            _x = ( i*(NODE_W+PADDING_X) ) - (root.m_children.length*(NODE_W+PADDING_X) )/2;

            var n = new BTNode({
                node: root.m_children[i],
                pos: new Vector(
                    _x+Luxe.screen.mid.x,
                    100+Luxe.screen.mid.y
                ),
                // batcher: batcher,
            });

        }
    }

}

class BTNode extends Visual
{

    public var node:Behavior;

    var _last_color:Int = BTVisual.C_INVALID;


    var _bright:Color;
    var _target:Color;

    override public function new(_options:BTNodeOptions)
    {
        node = _options.node;

        super({
            pos: _options.pos,
            geometry: Luxe.draw.box({
                x:0, y:0, w:BTVisual.NODE_W, h:BTVisual.NODE_H,
            }),
            color: new Color().rgb(BTVisual.C_INVALID),
            depth: 50,
            // batcher: _options.batcher,
        });
    }

    override function update(dt:Float)
    {
        switch(node.status){
            case INVALID: changeColor(BTVisual.C_INVALID);
            case SUCCESS: changeColor(BTVisual.C_SUCCESS);
            case FAILURE: changeColor(BTVisual.C_FAILURE);
            case RUNNING: changeColor(BTVisual.C_RUNNING);
        }
    }

    function changeColor(_color:Int)
    {
        if(_last_color != _color)
        {
            // remember
            _last_color = _color;
            _target = new Color().rgb(_color);

            // find brighter color
            _bright = new Color().rgb(_color);
            _bright.set(_bright.r+0.5, _bright.g+0.5, _bright.b+0.5);

            // set to brighter and tween down to target color
            color.set(_bright.r, _bright.g, _bright.b);
            color.tween(0.33, {
                r: _target.r,
                g: _target.g,
                b: _target.b
            });
        }
    }

}

typedef BTNodeOptions = {
    var node:Behavior;
    var pos:Vector;
    @:optional var batcher:Batcher;
}
