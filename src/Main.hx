
import luxe.Input;

class Main extends luxe.Game {

    public static var physics:Physics;

    override function ready() {

        physics = new Physics();

        var guy:Actor = new Actor({
            pos: Luxe.screen.mid.clone(),
            geometry: Luxe.draw.box({
                x:0, y:0, w:30, h:80,
            }),
        });
        guy.add( new components.Appearance() );

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main
