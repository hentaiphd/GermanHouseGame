package{
    import org.flixel.*;

    public class SelectorTextBox extends TextBox {
        [Embed(source="../assets/Select.png")] private var ImgSelector:Class;

        public var answers:FlxGroup;
        public var mouseRect:FlxRect;
        public var selector:FlxSprite;
        public var _label:String;

        public var selectionDelegate:MapRoom;

        public function SelectorTextBox(x:int, y:int, _text:String, label:String, opts:Array=null)
        {
            super(x, y, _text);

            answers = new FlxGroup();
            for(var i:Number = 0; i < opts.length; i++){
                var t:FlxText = new FlxText(x,y+((i*25)+10),boxWidth,opts[i]);
                t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
                answers.add(t);
                FlxG.state.add(t);
            }
            this._label = label;

            selector = new FlxSprite(t.x+20,t.y);
            selector.loadGraphic(ImgSelector, true, true, 16, 21, true);
            FlxG.state.add(selector);

            mouseRect = new FlxRect(FlxG.mouse.x,FlxG.mouse.y,1,1);
        }

        public function update():void{
            mouseRect.x = FlxG.mouse.x;
            mouseRect.y = FlxG.mouse.y;
            this.moveSelector();

            if (FlxG.mouse.justPressed() && this.selectionDelegate != null) {
                var choice:FlxText = this.getChoiceAtCursor();
                if (choice != null) {
                    this.selectionDelegate.didSelectTextOption(
                        this.answers.members.indexOf(choice), choice, this
                    );
                }
            }
        }

        public function moveSelector():void{
            var choice:FlxText = this.getChoiceAtCursor();
            if (choice != null) {
                selector.y = choice.y;
            }
        }

        private function getChoiceAtCursor():FlxText
        {
            for(var u:Number = 0; u < answers.length; u++){
                var r:FlxRect = new FlxRect(
                    answers.members[u].x,
                    answers.members[u].y,
                    boxWidth,
                    answers.members[u].height);
                if(r.overlaps(mouseRect)){
                    return answers.members[u] as FlxText;
                }
            }
            return null;
        }
    }
}
