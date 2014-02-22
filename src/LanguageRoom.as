package
{
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/Room-4-Language.png")] private var ImgLanguageRoom:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgLanguageRoom);
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