package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/0201-BG.png")] private var ImgBG:Class;
        [Embed(source="../assets/0202-Photographer.png")] private var ImgPhotographer:Class;

        private var photographer:FlxSprite;

        override public function create():void
        {
            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgBG);

            photographer = new FlxSprite(34, 96);
            photographer.loadGraphic(ImgPhotographer, true, true, 235, 220, true);
            add(photographer);

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
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
