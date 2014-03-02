package
{
    import org.flixel.*;

    public class TextState extends TimedState{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;
        public var _text:String;
        public var nextState:FlxState;

        public function TextState(_text:String, next:FlxState) {
            super();
            FlxG.bgColor = 0xffffffff;
            this._text = _text;
            this.nextState = next;
        }

        override public function create():void
        {
            endTime = 2;

            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,_text);
            t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
            add(t);
        }

        override public function update():void
        {
            super.update();
        }

        override public function endCallback():void {
            FlxG.switchState(nextState);
        }
    }
}
