package ;

import components.AIController;
import hxbt.Behavior;
import hxbt.BehaviorTree;
import hxbt.Composite;
import luxe.Camera;
import luxe.Color;
import luxe.Entity;
import luxe.options.VisualOptions;
import luxe.Rectangle;
import luxe.Scene;
import luxe.Text;
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
    public static inline var PADDING_Y:Float = 10;

    public static inline var NODE_W:Float = 30;
    public static inline var NODE_H:Float = 20;

    var root:Composite;

    var nodes:Array<BTNode>;
    var nodes_vis:Scene;

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

        nodes_vis = new Scene('btvisual');

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

        var _node:Behavior;

        // Nuke last tree
        clear_structure();

        // get TREE structure
        parse_structure();

        // draw it
        draw_structure();

    }

    function clear_structure()
    {
        for(e in nodes_vis.entities)
        {
            e.destroy();
        }

        nodes_vis.empty();
    }

    function parse_structure()
    {

        nodes = new Array<BTNode>();

        // root has children, so BTNode should be prepared
        nodes.push( new BTNode(root) );

    }

    function draw_structure()
    {

        var _lvl:Int = 0;    // how deep are we
        var _pos:Vector = new Vector(0,0);

        function place_nodes(_nodes:Array<BTNode>, _parent:BTNode)
        {

            var _i:Int = 0;
            var _len:Int = _nodes.length;

            for(n in _nodes){

                _i++;

                _pos.y = _lvl * NODE_W + PADDING_Y + this.pos.y;
                _pos.x = ( _i*(NODE_W+PADDING_X) ) - (_len*(NODE_W+PADDING_X) )/2 + this.pos.x;

                var vis = new BTNodeVisual({
                    name: 'btnodevisual_${_lvl},${_i}',
                    node: n.behavior,
                    node_parent: _parent.behavior,
                    pos: _pos,
                    scene: nodes_vis,
                    // parent: this,
                });

                if(n.children != null){
                    if(n.children.length > 0)
                    {
                        _lvl ++;
                        place_nodes(n.children, n);
                        _lvl --;
                    }
                }
            }

        }

        place_nodes(nodes[0].children, nodes[0]);
    }

    

}



class BTNode
{

    // Link to the real behavior i'm representing (also composites etc)
    public var behavior:hxbt.Behavior;

    // List of kids (if composite)
    public var children:Array<BTNode>;

    public function new(_behavior:hxbt.Behavior){

        behavior = _behavior;
        // if(behavior == null) throw 'whoops, not Behavior?';

        // If has cghildren
        // trace('GetClass = ${Type.getClass(_behavior)}');

        var arr:Array<String> = Type.getInstanceFields(Type.getClass(_behavior));
        if( arr.indexOf('m_children') >= 0 )
        {
            children = new Array<BTNode>();
            var _children:Array<Behavior> = Reflect.field(_behavior, 'm_children');

            for(c in _children)
            {
                // This will cause recurrence to all children
                children.push( new BTNode( c ) );
            }

        }

    }

}




class BTNodeVisual extends Visual
{

    // Used in children/parent to show/hide visual nodes
    public var node_parent:hxbt.Behavior;

    // Actual behavior connected with this node
    public var node:hxbt.Behavior;

    var label:Text;

    var _last_color:Int = BTVisual.C_INVALID;

    var _bright:Color;
    var _target:Color;

    override public function new(_options:BTNodeOptions)
    {
        node = _options.node;
        node_parent =_options.node_parent;

        _options.name_unique = true;
        _options.geometry = Luxe.draw.box({
            x:0, y:0, w:BTVisual.NODE_W, h:BTVisual.NODE_H,
        });
        _options.color = new Color().rgb(BTVisual.C_INVALID);
        _options.depth = 50;

        super(_options);

        label = new Text({
            name: 'label_&{_options.name}',
            name_unique: true,
            text: node.name,
            bounds: new Rectangle(0,0,BTVisual.NODE_W,BTVisual.NODE_H),
            bounds_wrap: true,
            point_size: 11,
            color: new Color(1,1,1),
            align: center,
            align_vertical: center,
            depth: this.depth + 0.1,
            parent: this,
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

        if(node_parent.status != INVALID){
            this.visible = true;
            label.visible = true;
        }else{
            this.visible = false;
            label.visible = false;
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
    > VisualOptions,

    var node:hxbt.Behavior;
    var node_parent:hxbt.Behavior;
}
