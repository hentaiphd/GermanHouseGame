package
{
    import org.flixel.*;

    public class UpstairsRoom extends MapRoom
    {
        [Embed(source="../assets/03-BG-01.png")] private var ImgBG:Class;
        [Embed(source="../assets/03-Door-01.png")] private var ImgDoor1:Class;
        [Embed(source="../assets/03-Door-02.png")] private var ImgDoor2:Class;
        [Embed(source="../assets/03-Stairs-01.png")] private var ImgStairs:Class;
        [Embed(source="../assets/03-Table-01.png")] private var ImgTable:Class;

        {
            public static var mainEntryPoint:FlxPoint = new FlxPoint(20, 350);
        }

        private var door1:FlxSprite, door2:FlxSprite, stairs:FlxSprite, table:FlxSprite;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgBG);

            stairs = new FlxSprite(0, 287);
            stairs.loadGraphic(ImgStairs, true, true, 218, 189, true);
            add(stairs);

            table = new FlxSprite(387, 61);
            table.loadGraphic(ImgTable, true, true, 142, 243, true);
            add(table);

            door1 = new FlxSprite(42, 0);
            door1.loadGraphic(ImgDoor1, true, true, 176, 21, true);
            add(door1);

            door2 = new FlxSprite(403, 449);
            door2.loadGraphic(ImgDoor2, true, true, 202, 29, true);
            add(door2);

            this.addClickZone(new FlxPoint(20, 400), new FlxPoint(40, 40),
                null, stairsTouched);
            this.addClickZone(new FlxPoint(20, 50), new FlxPoint(40, 40),
                null, languageDoorTouched);
            this.addClickZone(new FlxPoint(400, 400), new FlxPoint(40, 40),
                null, kidsDoorTouched);

            FlxG.mouse.show();

            var entryPoint:FlxPoint = mainEntryPoint;
            var lastExitPoint:FlxPoint = HouseMap.getInstance().popExitPoint();
            entryPoint = lastExitPoint;
            player = new Player(entryPoint.x, entryPoint.y);
            add(player);

            this.addClickZone(
                new FlxPoint(500,210),
                new FlxPoint(100,200),
                null,
                conversation(new FlxPoint(10,10), new FlxPoint(300, 100),"Hello I am a text box!", "")
            );
        }

        private function stairsTouched(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }

        private function kidsDoorTouched(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            FlxG.switchState(new KidsRoom());
        }

        private function languageDoorTouched(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            FlxG.switchState(new LanguageRoom());
        }
    }
}
