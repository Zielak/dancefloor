
import luxe.Input;
import luxe.Rectangle;
import luxe.utils.Maths;
import luxe.utils.Random;

class Main extends luxe.Game {

    public static var physics:Physics;
    public static var random:Random;

    override function ready() {

        physics = Luxe.physics.add_engine(Physics);

        random = new Random(1);

        spawn_people();

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update












    function spawn_people()
    {
        for( i in 0...10 )
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

        HumanVisual.watch(guy);
    }    

} //Main
