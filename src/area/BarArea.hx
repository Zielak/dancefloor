package area;

import luxe.options.ComponentOptions;

class BarArea extends FixedComponent
{

    public var sells:Map<BarStockType, Bool>;


    override public function new(_options:BarAreaOptions)
    {
        super(_options);

        sells = _options.sells;
    }

}

typedef BarAreaOptions = {
    > ComponentOptions,

    var sells:Map<BarStockType, Bool>;

}

enum BarStockType {

    food;
    drink;
    liquor;

}
