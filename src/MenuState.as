package
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        [Embed(source="../assets/Title.png")] private var BG:Class;
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")]
        public var FontLea:String;
        public var bg:FlxSprite;
        public var t:FlxText;

        override public function create():void
        {
            FlxG.bgColor = 0xffffffff;
            bg = new FlxSprite(0,0);
            bg.loadGraphic(BG,false,false,640,480);
            add(bg);

            t = new FlxText(215,200,100,"click to play");
            t.setFormat("LeaBlock-Regular",18,0xff000000,"center");
            add(t);

            FlxG.mouse.show();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.mouse.justPressed())
            {
                FlxG.mouse.hide();
                FlxG.switchState(new LobbyRoom());
            }
        }
    }
}
