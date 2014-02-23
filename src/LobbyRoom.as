package
{
    import org.flixel.*;

    public class LobbyRoom extends MapRoom
    {
        [Embed(source="../assets/0101-BG.png")] private var ImgRoomLobby:Class;
        [Embed(source="../assets/0102-Stairs.png")] private var ImgStairs:Class;
        [Embed(source="../assets/0103-Door.png")] private var ImgDoor:Class;
        [Embed(source="../assets/0104-Student Worker.png")] private var ImgStudentWorker:Class;
        [Embed(source="../assets/Bubble-01.png")] private var ImgWorkerBubble:Class;
        [Embed(source="../assets/Bubble-02.png")] private var ImgKidBubble:Class;

        public var debugText:FlxText;
        public var worker:FlxSprite;
        public var stairs:FlxSprite;
        public var door:FlxSprite;
        public var workerBubble:FlxSprite;
        public var kidBubble:FlxSprite;

        {
            public static var mainEntryPoint:FlxPoint = new FlxPoint(280, 270);
        }

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomLobby);

            stairs = new FlxSprite(0, 0);
            stairs.loadGraphic(ImgStairs, true, true, 243, 475, true);
            add(stairs);

            door = new FlxSprite(159, 461);
            door.loadGraphic(ImgDoor, true, true, 194, 13, true);
            add(door);

            worker = new FlxSprite(433, 269);
            worker.loadGraphic(ImgStudentWorker, true, true, 179, 209, true);
            add(worker);

            workerBubble = new FlxSprite(377, 103);
            workerBubble.loadGraphic(ImgWorkerBubble, true, true, 249, 166, true);
            add(workerBubble);

            kidBubble = new FlxSprite(7, 130);
            kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
            add(kidBubble);

            FlxG.mouse.show();

            debugText = new FlxText(100,100,FlxG.width,"");
            add(debugText);

            var entryPoint:FlxPoint = mainEntryPoint;
            var lastExitPoint:FlxPoint = HouseMap.getInstance().popExitPoint();
            if (lastExitPoint != null) {
                entryPoint = lastExitPoint;
            }
            player = new Player(entryPoint.x, entryPoint.y);
            add(player);

            this.addClickZone(new FlxPoint(400,280), new FlxPoint(200,200),
                              null, conversation(10,10,"Hello I am a text box!", true, new Array("one","two","three")));
            this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                              null, doorWasClicked);
            this.addClickZone(new FlxPoint(300, 100), new FlxPoint(40, 40),
                              null, stairsTouched);
        }

        override public function update():void{
            super.update();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            HouseMap.getInstance().pushExitPoint(UpstairsRoom.mainEntryPoint);
            FlxG.switchState(new UpstairsRoom());
        }

        private function stairsTouched(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            FlxG.switchState(new CultureRoom());
        }
    }
}
