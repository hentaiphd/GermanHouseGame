package{
    import org.flixel.*;

    public class TextBox{
        public var text:FlxText;
        public var box:FlxSprite;
        public var boxWidth:Number = 300;
        public var boxHeight:Number = 100;

        public function TextBox(x:int, y:int, _text:String){
            box = new FlxSprite(x,y);
            box.makeGraphic(boxWidth,boxHeight,0xffBAF0FF);
            box.immovable = true;
            FlxG.state.add(box);

            text = new FlxText(x,y,boxWidth,_text);
            text.color = 0xff000000;
            text.size = 16;
            FlxG.state.add(text);
        }
    }
}