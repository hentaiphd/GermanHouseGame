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
        public var workerText:TextBox;
        public var kidBubble:FlxSprite;

        public var current_scene:Number = 1;

        private static const STATE_INTRO:int = 1;
        private static const STATE_MAIN:int = 2;
        private var currentState:int = STATE_INTRO;

        private const ALPHA_DELTA:Number = .04;

        private var lastSelectionTimeFrame:Number = -1;

        private static const SEL_LANG:String = "lang_sel";

        {
            public static var mainEntryPoint:FlxPoint = new FlxPoint(320, 370);
        }

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomLobby);

            if (HouseMap.getInstance().hasSeenIntroSequence) {
                currentState = STATE_MAIN;
            } else {
                currentState = STATE_INTRO;
            }

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
            workerBubble.alpha = 0;
            add(workerBubble);

            workerText = new TextBox(new FlxPoint(399, 113), new FlxPoint(220, 100),
                                     "Hey kid, are you looking for your mom 'n dad?");
            workerText.alpha = 0;
            add(workerText);

            kidBubble = new FlxSprite(7, 130);
            kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
            kidBubble.alpha = 0;
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

            conversation(new FlxPoint(kidBubble.x+40, kidBubble.y),new FlxPoint(250, 100),"", SEL_LANG,
                         new Array("Yes!","Kannst du auch Deutsch?"), this, true)();
        }

        override public function update():void{
            super.update();

            if (current_scene == 1 && (timeFrame == 3*TimedState.fpSec)) {
                current_scene += 1;
            } else if (current_scene == 2 && (timeFrame == 6*TimedState.fpSec)) {
                current_scene += 1;
            } else if (current_scene == 3) {

            } else if (current_scene == 4 && (timeFrame == lastSelectionTimeFrame+5*TimedState.fpSec)) {
                currentState = STATE_MAIN;
                player.shouldMove = true;
                HouseMap.getInstance().hasSeenIntroSequence = true;
            }

            if (current_scene == 2) {
                workerBubble.alpha += ALPHA_DELTA;
                workerText.alpha += ALPHA_DELTA;
            } else if (current_scene == 3) {
                kidBubble.alpha += ALPHA_DELTA;
                this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
            } else if (current_scene == 4) {

            }

            if (currentState == STATE_INTRO) {

            } else if (currentState == STATE_MAIN) {
                workerBubble.alpha -= ALPHA_DELTA;
                workerText.alpha -= ALPHA_DELTA;
                player.shouldMove = true;
            }
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
            if (currentState == STATE_INTRO && current_scene == 3
                && selector._label == SEL_LANG)
            {
                current_scene += 1;

                lastSelectionTimeFrame = timeFrame;

                selector.destroy();
                FlxG.state.remove(kidBubble);


                if (idx == 0) {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_EN;
                } else {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;
                }

                if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                    workerText.text = "Well, I saw them around a while ago. They have to be here somewhere!";
                } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                    workerText.text = "Klar! Deine Eltern hab ich vorhin noch gesehen. Sie müssen hier irgendwo sein!";
                }

            }
        }
    }
}
