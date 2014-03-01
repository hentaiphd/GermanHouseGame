package
{
    import org.flixel.*;

    public class KidsGuess extends FlxSprite
    {
        public var _origin:FlxPoint;
        public var choices_en:Array;
        public var choices_de:Array;
        public var correct_idx:Number;

        public function KidsGuess(img:Class, origin:FlxPoint, size:FlxPoint,
                                  choices_de:Array, choices_en:Array,
                                  correct_idx:Number)
        {
            super(origin.x, origin.y);
            loadGraphic(img, true, true, size.x, size.y, true);

            this._origin = origin;
            this.choices_en = choices_en;
            this.choices_de = choices_de;
            this.correct_idx = correct_idx;
        }
    }
}
