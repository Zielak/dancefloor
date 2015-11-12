package components;

import components.InputAI;
import hxbt.BehaviorTree;
import hxbt.composites.Sequence;
import hxbt.composites.Selector;
import hxbt.composites.Parallel;

class AIController extends FixedComponent
{

    public var m_tree:BehaviorTree;

    var root:Sequence;

    override function init()
    {
        type = controller;

        m_tree = new BehaviorTree();


        root = new Sequence();
        root.add(new behaviors.MoveInRandomDirection({time: 1, randomizeTime: 1}));
        root.add(new behaviors.Dance({time: 2, randomizeTime: 1}));
        root.add(new behaviors.Wait({time: 0.5, randomizeTime: 0.5}));



// Check Hunger
        var checkHunger_seq = new Sequence();
        checkHunger_seq.add(new behaviors.Wait({time: 0.2, randomizeTime: 0.2}));
        checkHunger_seq.add(new behaviors.CheckAttributeHunger());
        
        root.add(checkHunger_seq);


// Check Thirst
        var checkThirst_seq = new Sequence();
        checkThirst_seq.add(new behaviors.Wait({time: 0.2, randomizeTime: 0.2}));
        checkThirst_seq.add(new behaviors.CheckAttributeThirst());

        root.add(checkThirst_seq);

// Check Attributes
        var checkAttributes_sel = new Selector();
        checkAttributes_sel.add(checkHunger_seq);
        checkAttributes_sel.add(checkThirst_seq);





        
// Testing nested sequence
        var seq1 = new Sequence();
        seq1.add(new behaviors.Wait({time: 0.5, randomizeTime: 0.5}));
        seq1.add(new behaviors.Dance({time: 2, randomizeTime: 1}));

        root.add(seq1);



// Testing nested selector 
        var sel1 = new Selector();
        sel1.add(new behaviors.Wait({time: 0.5, randomizeTime: 0.2}));
        sel1.add(new behaviors.Wait({time: 1, randomizeTime: 0.2}));
        sel1.add(new behaviors.Wait({time: 1.5, randomizeTime: 0.2}));
        sel1.add(new behaviors.Wait({time: 2, randomizeTime: 0.2}));

        // root.add(sel1);

// Root
        m_tree.setRoot(root);
        m_tree.setContext({actor: cast(entity, Actor)});

// Events
        Luxe.events.fire( 'human.watch', {human: cast(actor, Human)} );

    }

    override function onremoved()
    {
        m_tree = null;
        root = null;

        super.onremoved();
    }

    override public function step(dt : Float)
    {
        m_tree.update(dt);
    }

}
