package{
    import org.flixel.*;

    public class TextBox{
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")]
        //[Embed(source="../assets/0101-BG.png")] private var ImgRoomLobby:Class;
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
        public var mouseRect:FlxRect;

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
                    var t:FlxText = new FlxText(x,y+((i*25)+10),boxWidth,opts[i]);
                    t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
                    answers.add(t);
                    FlxG.state.add(t);
                }

                selector = new FlxSprite(t.x-5,t.y);
                FlxG.state.add(selector);

                mouseRect = new FlxRect(FlxG.mouse.x,FlxG.mouse.y,1,1);
            }

            text = new FlxText(x,y,boxWidth,_text);
            text.setFormat("LeaBlock-Regular",18,0xff000000,"center");
            FlxG.state.add(text);
        }

        public function update():void{
            super.update();
            var f:FlxText = new FlxText(10,10,100,"move damn it");
            f.color = 0xff000000;
            FlxG.state.add(f);

            if(isSelector){
                mouseRect.x = FlxG.mouse.x;
                mouseRect.y = FlxG.mouse.y;
                moveSelector();
            }
        }

        public function moveSelector():void{
            for(var u:Number = 0; u < answers.length; u++){
                var r:FlxRect = new FlxRect(answers.members[u].x,answers.members[u].y,boxWidth, answers.members[u].height);
                if(r.overlaps(mouseRect)){
                    selector.y = answers.members[u].y;
                }
            }
        }
    }
}