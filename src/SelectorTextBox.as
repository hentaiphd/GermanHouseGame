package{
    import org.flixel.*;

    public class SelectorTextBox extends TextBox {
        [Embed(source="../assets/Select.png")] private var ImgSelector:Class;

        public var answers:FlxGroup;
        public var mouseRect:FlxRect;
        public var selector:FlxSprite;

        public function SelectorTextBox(x:int, y:int, _text:String, opts:Array=null)
        {
            super(x, y, _text);
            answers = new FlxGroup();
            for(var i:Number = 0; i < opts.length; i++){
                var t:FlxText = new FlxText(x,y+((i*25)+10),boxWidth,opts[i]);
                t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
                answers.add(t);
                FlxG.state.add(t);
            }

            selector = new FlxSprite(t.x+20,t.y);
            selector.loadGraphic(ImgSelector, true, true, 16, 21, true);
            FlxG.state.add(selector);

            mouseRect = new FlxRect(FlxG.mouse.x,FlxG.mouse.y,1,1);
        }

        public function update():void{
            mouseRect.x = FlxG.mouse.x;
            mouseRect.y = FlxG.mouse.y;
            this.moveSelector();
        }

        public function moveSelector():void{
            for(var u:Number = 0; u < answers.length; u++){
                var r:FlxRect = new FlxRect(
                    answers.members[u].x,
                    answers.members[u].y,
                    boxWidth,
                    answers.members[u].height);
                if(r.overlaps(mouseRect)){
                    selector.y = answers.members[u].y;
                }
            }
        }
    }
}
