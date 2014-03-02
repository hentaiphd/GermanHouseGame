package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class AnimatedCursor extends FlxSprite
    {
    [Embed(source="../assets/Cursor.png")] private var ImgCursor:Class;
    public var hovering:Boolean = false;
    public var optionHover:Boolean = false;
    public var rect:FlxRect;

        public function AnimatedCursor()
        {
            super();
            loadGraphic(ImgCursor, true, true, 47, 41);
            rect = new FlxRect(x, y, 1, 1);
            addAnimation("normal", [0], 12);
            addAnimation("hover", [1,2,3,4], 12);
            addAnimation("pressed", [5], 12);
        }

        override public function update():void
        {
            super.update();
            x = FlxG.mouse.x-15;
            y = FlxG.mouse.y-5;
            rect.x = x;
            rect.y = y;

            if(FlxG.mouse.pressed() || this.optionHover){
                play("pressed");
            } else if(hovering){
                play("hover");
            } else{
                play("normal");
            }
        }
    }
}
