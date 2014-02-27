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
            this.addClickZone(new FlxPoint(stairs.x, stairs.y), new FlxPoint(stairs.width, stairs.height),
                null, stairsTouched);

            table = new FlxSprite(387, 61);
            table.loadGraphic(ImgTable, true, true, 142, 243, true);
            add(table);

            door1 = new FlxSprite(42, 0);
            door1.loadGraphic(ImgDoor1, true, true, 176, 21, true);
            add(door1);
            this.addClickZone(new FlxPoint(door1.x, door1.y), new FlxPoint(door1.width, door1.height),
                null, languageDoorTouched);

            door2 = new FlxSprite(403, 449);
            door2.loadGraphic(ImgDoor2, true, true, 202, 29, true);
            add(door2);
            this.addClickZone(new FlxPoint(door2.x, door2.y), new FlxPoint(door2.width, door2.height),
                null, kidsDoorTouched);


            FlxG.mouse.show();

            var entryPoint:FlxPoint = mainEntryPoint;
            var lastExitPoint:FlxPoint = HouseMap.getInstance().popExitPoint();
            entryPoint = lastExitPoint;
            player = new Player(entryPoint.x, entryPoint.y);
            add(player);
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
