package
{
    import org.flixel.*;

    public class KidsRoom extends MapRoom
    {
        [Embed(source="../assets/Room-5-Kids.png")] private var ImgKidsRoom:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgKidsRoom);
            this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                null, doorWasClicked);

            FlxG.mouse.show();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new UpstairsRoom());
        }
    }
}