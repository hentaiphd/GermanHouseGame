package{
    import org.flixel.*;

    public class TextBox{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")]
        public var FontLea:String;
        public var text:FlxText;
        public var box:FlxSprite;
        public var boxWidth:Number = 300;
        public var boxHeight:Number = 100;
        public var destination:FlxPoint;
        public var boxPoint:FlxPoint;
        public var selector:FlxSprite;
        public var isSelector:Boolean = false;
        public var answers:FlxGroup;
        public var mousePos:FlxSprite;

        public function TextBox(x:int, y:int, _text:String, selecting:Boolean = false, opts:Array = null){
            boxPoint = new FlxPoint(x,y);
            isSelector = selecting;

            box = new FlxSprite(x,y);
            box.makeGraphic(boxWidth,boxHeight,0xffBAF0FF);
            box.immovable = true;
            FlxG.state.add(box);

            if(isSelector){
                answers = new FlxGroup();
                for(var i:Number = 0; i < opts.length; i++){
                    var t:FlxText = new FlxText(x,(y+10)+(i*2),boxWidth,opts[i]);
                    t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
                    answers.add(t);
                    FlxG.state.add(t);
                }

                selector = new FlxSprite(t.x-10,t.y);
                FlxG.state.add(selector);

                mousePos = new FlxSprite(FlxG.mouse.x,FlxG.mouse.y);
            }

            text = new FlxText(x,y,boxWidth,_text);
            text.setFormat("LeaBlock-Regular",18,0xff000000,"center");
            FlxG.state.add(text);
        }

        public function update():void{
            super.update();

            if(isSelector){
                mousePos.x = FlxG.mouse.x;
                mousePos.y = FlxG.mouse.y;
                moveSelector();
            }
        }

        public function moveSelector():void{
            for(var u:Number = 0; u < answers.length; u++){
                if(FlxG.collide(mousePos,answers.members[u])){
                    selector.x = answers.members[u].x;
                    selector.y = answers.members[u].y;
                }
            }
        }
    }
}