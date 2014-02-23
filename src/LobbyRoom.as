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

        public var worker:FlxSprite;
        public var stairs:FlxSprite;
        public var door:FlxSprite;
        public var workerBubble:FlxSprite;
        public var kidBubble:FlxSprite;

        private static const STATE_INTRO:int = 1;
        private static const STATE_MAIN:int = 2;
        private var currentState:int = STATE_INTRO;

        private static const SEL_LANG:String = "lang_sel";

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

            var entryPoint:FlxPoint = mainEntryPoint;
            var lastExitPoint:FlxPoint = HouseMap.getInstance().popExitPoint();
            if (lastExitPoint != null) {
                entryPoint = lastExitPoint;
            }
            player = new Player(entryPoint.x, entryPoint.y);
            player.shouldMove = false;
            add(player);

            this.addClickZone(new FlxPoint(400,280), new FlxPoint(200,200),
                              null, null);
            this.addClickZone(new FlxPoint(350, 0), new FlxPoint(300, 10),
                              null, doorWasClicked);
            this.addClickZone(new FlxPoint(0, 0), new FlxPoint(200, 200),
                              null, stairsTouched);

            debugText = new FlxText(200,200,FlxG.width,"");
            debugText.color = 0xff000000;
            add(debugText);

            conversation(kidBubble.x, kidBubble.y,"", SEL_LANG,
                         new Array("Hi","Kannst du auch Deutsch?"), this)();
        }

        override public function update():void{
            super.update();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            HouseMap.getInstance().pushExitPoint(UpstairsRoom.mainEntryPoint);
            FlxG.switchState(new CultureRoom());
        }

        private function stairsTouched(a:FlxSprite, b:FlxSprite):void
        {
            HouseMap.getInstance().pushExitPoint(player.pos);
            FlxG.switchState(new UpstairsRoom());
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_INTRO && selector._label == SEL_LANG) {
                currentState = STATE_MAIN;

                selector.destroy();
                FlxG.state.remove(kidBubble);
                FlxG.state.remove(workerBubble);

                if (idx == 0) {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_EN;
                } else {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;
                }

                player.shouldMove = true;
            }
        }
    }
}
