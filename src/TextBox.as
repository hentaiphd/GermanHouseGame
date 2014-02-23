package{
    import org.flixel.*;

    public class TextBox extends FlxText{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;

        public var box:FlxSprite;
        public var boxWidth:Number = 300;
        public var boxHeight:Number = 100;
        public var destination:FlxPoint;
        public var boxPoint:FlxPoint;
        public var debugText:FlxText;

        public function TextBox(origin:FlxPoint, size:FlxPoint, _text:String){
            boxPoint = new FlxPoint(origin.x, origin.y);

            box = new FlxSprite(size.x, size.y);
            box.makeGraphic(size.x, size.y, 0x00BAF0FF);
            box.immovable = true;
            FlxG.state.add(box);

            super(origin.x, origin.y, size.x, _text);
            this.setFormat("LeaBlock-Regular",18,0xff000000,"left");

            debugText = new FlxText(10,10,100,"move damn it");
            debugText.color = 0xff000000;
        }
    }
}
