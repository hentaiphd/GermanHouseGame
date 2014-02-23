package
{
    import org.flixel.*;

    public class KidsRoom extends MapRoom
    {
        [Embed(source="../assets/Room-5-Kids.png")] private var ImgKidsRoom:Class;

        //german player version
        //barbeque - dog, boat, potassium, scanner, menu
        //peanut - house, shark, garage, pulp, beaker
        //curtains - printer, shelf, wallpaper, liquid, canary
        //chandelier - barcode, laser, comforter, outhouse, cot
        //asparagus - purse, skyscraper, guava, grapefruit, towel
        //bandana - banana, sherbet, alley, stool, ramp

        override public function create():void
        {
            HouseMap.getInstance().KidsRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
                this.setupBackground(ImgKidsRoom);
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
            FlxG.switchState(new UpstairsRoom());
        }
    }
}