
package utils;

class FloatUtil
{

    /**
     * Limit value to the given range
     * @param  v   float
     * @param  min down
     * @param  max top
     * @return     limited float
     */
    public static inline function limitTo( v:Float, min:Float, max:Float ):Float {

        if(v > max){
            v = max;
        }else if(v < min){
            v = min;
        }

        return v;

    }

    /**
     * Limit Float to 0...1 range
     * @param  v   [description]
     * @return     [description]
     */
    public static inline function limit( v:Float ):Float {

        if(v > 1){
            v = 1;
        }else if(v < 0){
            v = 0;
        }

        return v;

    }

}
