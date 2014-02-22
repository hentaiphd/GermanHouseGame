package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/Room-2-Culture.png")] private var ImgCultureRoom:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgCultureRoom);
            this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                null, doorWasClicked);

            FlxG.mouse.show();

            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }
    }
}