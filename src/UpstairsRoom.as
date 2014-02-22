package
{
    import org.flixel.*;

    public class UpstairsRoom extends MapRoom
    {
        [Embed(source="../assets/Room-3-Upper-Level.png")] private var ImgRoomUpperLevel:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomUpperLevel);
            this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                              null, doorWasClicked);
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }
    }
}
