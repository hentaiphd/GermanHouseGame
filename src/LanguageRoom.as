package
{
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/Room-4-Language.png")] private var ImgLanguageRoom:Class;

        override public function create():void
        {
            HouseMap.getInstance().LangRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
                this.setupBackground(ImgLanguageRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);
            }
        }

        override public function update():void{
            super.update();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new UpstairsRoom());
        }
    }
}