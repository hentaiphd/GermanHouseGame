package{
    import org.flixel.*;

    public class DHFadeText extends FlxText{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;

        public function DHFadeText(origin:FlxPoint, size:FlxPoint, _text:String){
            super(origin.x, origin.y, size.x, _text);
            this.setFormat("LeaBlock-Regular",18,0xff000000,alignment);
        }

        override public function update():void
        {
            super.update();
            this.alpha -= .01;
        }
    }
}
