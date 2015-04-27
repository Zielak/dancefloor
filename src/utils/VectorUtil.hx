
package utils;

import luxe.Vector;

class VectorUtil
{

    public static function x_int( v:Vector ):Int
    {
        return Math.floor(v.x);
    }

    public static function y_int( v:Vector ):Int
    {
        return Math.floor(v.y);
    }


    public static function get_length2D( v:Vector ):Float
    {

        return Math.sqrt( v.x * v.x + v.y * v.y );

    } //length2D


    public static function set_length2D( v:Vector, value:Float ):Vector
    {

        return normalize2D(v).multiplyScalar( value );

    } //length2D

    public static function normalize2D( v:Vector ):Vector
    {

        if ( get_length2D(v) != 0 ) {

            v.set_xy( v.x / get_length2D(v), v.y / get_length2D(v) );

        } else {

            v.set_xy(0, 0);

        }

        return v;
    } //normalize2D

    public static inline function multiplyScalar2D( v:Vector, value:Float ):Vector {

        v.set_xy( v.x * value, v.y * value );

        return v;

    } //multiplyScalar2D

}
