package components;

import components.InputAI;
import hxbt.BehaviorTree;
import hxbt.composites.Sequence;

class AIController extends FixedComponent
{

    public var m_tree:BehaviorTree;

    var seq:Sequence;

    override function init()
    {
        type = controller;

        m_tree = new BehaviorTree();

        seq = new Sequence();
        seq.add(new behaviors.Wait({time: 0.5, randomizeTime: 0.5}));
        seq.add(new behaviors.MoveInRandomDirection({time: 1, randomizeTime: 1}));
        seq.add(new behaviors.Dance({time: 2, randomizeTime: 1}));

        m_tree.setRoot(seq);
        m_tree.setContext({actor: cast(entity, Actor)});

        Luxe.events.fire( 'human.watch', {human: cast(actor, Human)} );
    }

    override function onremoved()
    {
        m_tree = null;
        seq = null;

        super.onremoved();
    }

    override public function step(dt : Float)
    {
        m_tree.update(dt);
    }

}
