
import luxe.Input;
import luxe.Rectangle;
import luxe.utils.Maths;

class Main extends luxe.Game {

    public static var physics:Physics;

    override function ready() {

        physics = Luxe.physics.add_engine(Physics);

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
        _pos.x += Maths.random_float(-100, 100);
        _pos.y += Maths.random_float(-100, 100);

        var guy:Human = new Human({pos: _pos});
        guy.add( new components.Bounds({
            bounds:new Rectangle(
                30, 30, Luxe.screen.w-30, Luxe.screen.h-30
            )})
        );
    }    

} //Main
