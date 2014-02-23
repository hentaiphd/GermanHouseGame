package{
    import org.flixel.*;

    public class TextBox{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;

        public var text:FlxText;
        public var box:FlxSprite;
        public var boxWidth:Number = 300;
        public var boxHeight:Number = 100;
        public var destination:FlxPoint;
        public var boxPoint:FlxPoint;
        public var debugText:FlxText;

        public function TextBox(x:int, y:int, _text:String){
            boxPoint = new FlxPoint(x,y);

            box = new FlxSprite(x,y);
            box.makeGraphic(boxWidth,boxHeight,0x00BAF0FF);
            box.immovable = true;
            FlxG.state.add(box);

            text = new FlxText(x,y,boxWidth,_text);
            text.setFormat("LeaBlock-Regular",18,0xff000000,"center");
            FlxG.state.add(text);

            debugText = new FlxText(10,10,100,"move damn it");
            debugText.color = 0xff000000;
        }
    }
}
