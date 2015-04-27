
import luxe.Input;
import luxe.utils.Maths;

class Main extends luxe.Game {

    public static var physics:Physics;

    override function ready() {

        physics = new Physics();

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
        for( i in 0...30 )
        {
            spawn_guy();
        }
    }

    function spawn_guy()
    {
        var _pos = Luxe.screen.mid.clone();
        _pos.x += Maths.random_float(-200, 200);
        _pos.y += Maths.random_float(-100, 100);

        var guy:Human = new Human({
            pos: _pos,
            geometry: Luxe.draw.box({
                x:0, y:0, w:30, h:80,
            }),
        });
    }    

} //Main
