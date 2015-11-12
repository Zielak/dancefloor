
import luxe.Color;
import luxe.Input;
import luxe.Rectangle;
import luxe.utils.Maths;
import luxe.utils.Random;
import luxe.Text;

class Main extends luxe.Game {

    public static var physics:Physics;
    public static var random:Random;

    public var humanVisual:HumanVisual;
    public var btVisual:BTVisual;

    var tips_txt:Text;

    override function ready() {

        physics = Luxe.physics.add_engine(Physics);
        random = new Random(1);

        humanVisual = new HumanVisual();
        btVisual = new BTVisual();

        spawn_people();
        spawn_areas();

        tips_txt = new Text({
            bounds: new Rectangle(10, Luxe.screen.h-20, Luxe.screen.w, 20),
            point_size: 12,
            color: new Color().rgb(0x666666),
            text: '[Click] inspect human, [P] pause, [O] step one frame',
        });

        physics.paused = false;

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

        if(e.keycode == Key.key_p) {
            physics.pause();
        }
        if(e.keycode == Key.key_o) {
            physics.forceStep();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update












    function spawn_people()
    {
        for( i in 0...100 )
        {
            spawn_guy();
        }
    }

    function spawn_guy()
    {
        var _pos = Luxe.screen.mid.clone();
        _pos.x += random.float(-100, 100);
        _pos.y += random.float(-100, 100);

        var guy:Human = new Human({pos: _pos});
        guy.add( new components.Bounds({
            bounds:new Rectangle(
                30, 30, Luxe.screen.w-30, Luxe.screen.h-30
            )})
        );

        Luxe.events.fire( 'human.watch', {human: guy} );
    }


    function spawn_areas()
    {
        var bar_area:Area = new Area({
            bounds: new Rectangle(Luxe.screen.w/8*6, Luxe.screen.h/4, Luxe.screen.w/8, Luxe.screen.h/4*2)
        });
        bar_area.add(new area.BarArea({
            sells:[
                food => true,
                drink => true,
                liquor => true,
            ]
        }));
    }

} //Main
