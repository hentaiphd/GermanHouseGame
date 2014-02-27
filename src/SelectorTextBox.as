package{
    import org.flixel.*;

    public class SelectorTextBox extends TextBox {
        [Embed(source="../assets/Select.png")] private var ImgSelector:Class;

        public var answers:FlxGroup;
        public var mouseRect:FlxRect;
        public var selector:FlxSprite;
        public var transparent:Boolean;
        public var _label:String;

        public var selectionDelegate:MapRoom;

        public function SelectorTextBox(origin:FlxPoint, size:FlxPoint,
                                        _text:String, label:String,
                                        opts:Array=null, transparent:Boolean=false,
                                        lineHeight:Number=25)
        {
            super(origin, size, _text);
            FlxG.state.add(this);

            answers = new FlxGroup();
            for(var i:Number = 0; i < opts.length; i++){
                var t:FlxText = new FlxText(origin.x,origin.y+((i*lineHeight)+lineHeight),size.x,opts[i]);
                t.setFormat("LeaBlock-Regular",18,0xff000000,"left");
                answers.add(t);
                FlxG.state.add(t);
                if (transparent) {
                    t.alpha = 0;
                }
            }
            this._label = label;

            selector = new FlxSprite(t.x-20,t.y);
            selector.loadGraphic(ImgSelector, true, true, 16, 21, true);
            FlxG.state.add(selector);
            if (transparent) {
                selector.alpha = 0;
                this.alpha = 0;
            }

            mouseRect = new FlxRect(FlxG.mouse.x,FlxG.mouse.y,1,1);
        }

        public function incrementAlpha(inc:Number):void
        {
            this.alpha += inc;
            this.selector.alpha += inc;
            for(var u:Number = 0; u < answers.length; u++){
                answers.members[u].alpha += inc;
            }
        }

        override public function update():void{
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
                selector.y = choice.y + 5;
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

        override public function destroy():void
        {
            FlxG.state.remove(selector);
            for(var u:Number = 0; u < answers.length; u++){
                FlxG.state.remove(answers.members[u]);
            }
        }
    }
}
