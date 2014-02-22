package
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        [Embed(source="../assets/Title.png")] private var ImgBG:Class;
        [Embed(source="../assets/Door.png")] private var ImgDoor:Class;
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")]
        public var FontLea:String;
        public var bg:FlxSprite;

        override public function create():void
        {
            FlxG.bgColor = 0xffffffff;
            bg = new FlxSprite(0,0);
            bg.loadGraphic(ImgBG,false,false,640,480);
            add(bg);

            var door:FlxSprite = new FlxSprite(198, 160);
            door.loadGraphic(ImgDoor, false, false, 222, 317);
            add(door);

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
