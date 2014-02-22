package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/Room-2-Culture.png")] private var ImgCultureRoom:Class;

        override public function create():void
        {
            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
                this.setupBackground(ImgCultureRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);
            }
            player = new Player(20,150);
            add(player);
        }

        override public function update():void{
            super.update();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }
    }
}