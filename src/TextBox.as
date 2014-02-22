package{
    import org.flixel.*;

    public class TextBox{
        public var text:FlxText;
        public var box:FlxSprite;

        public function TextBox(x:int, y:int, _text:String){
            box = new FlxSprite(x,y);
            box.makeGraphic(200,50);
            FlxG.state.add(box);

            text = new FlxText(x,y,200,_text);
            text.color = 0xff000000;
            FlxG.state.add(text);
        }
    }
}