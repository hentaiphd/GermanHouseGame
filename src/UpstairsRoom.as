package
{
    import org.flixel.*;

    public class UpstairsRoom extends MapRoom
    {
        [Embed(source="../assets/03-BG-01.png")] private var ImgBG:Class;
        [Embed(source="../assets/03-POPUP-01.png")] private var ImgPostcard:Class;
        [Embed(source="../assets/03-Kids.png")] private var ImgKids:Class;
        [Embed(source="../assets/03-Language-01.png")] private var ImgLanguage:Class;
        [Embed(source="../assets/language.mp3")] private var SndBGM:Class;

        {
            public static var mainEntryPoint:FlxPoint = new FlxPoint(250, 170);
        }

        private var door1:FlxSprite, door2:FlxSprite, stairs:FlxSprite, table:FlxSprite;
        private var postcardTouchTime:Number = -1;
        private var postcard:FlxSprite;

        private var kids:FlxSprite, languageSprite:FlxSprite;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgBG);

            kids = new FlxSprite(293, 364);
            kids.loadGraphic(ImgKids, true, true, 1520/10, 111, true);
            kids.addAnimation("run", [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 8, 7, 6, 5,
                4, 4, 3, 2, 1, 1, 0, 6, 5,
                4, 4, 3, 2, 1, 1, 0, 6, 5,
                4, 4, 3, 2, 1, 1, 0, 6, 5,
                4, 4, 5, 5, 6, 7, 8
                ], 12, true);
            add(kids);
            kids.play("run");

            languageSprite = new FlxSprite(45, 29);
            languageSprite.loadGraphic(ImgLanguage, true, true, 384/3, 71, true);
            languageSprite.addAnimation("run", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], 12, true);
            add(languageSprite);
            languageSprite.play("run");

            this.addClickZone(new FlxPoint(0, 287), new FlxPoint(218, 189),
                null, stairsTouched);

            this.addClickZone(new FlxPoint(42, 0), new FlxPoint(176, 21),
                null, languageDoorTouched);

            this.addClickZone(new FlxPoint(403, 449-20), new FlxPoint(202, 29+20),
                null, kidsDoorTouched);

            var entryPoint:FlxPoint = mainEntryPoint;
            player = new Player(entryPoint.x, entryPoint.y);
            add(player);

            postcard = new FlxSprite(20, 20);
            postcard.loadGraphic(ImgPostcard, true, true, 595, 445);
            postcard.alpha = 0;
            add(postcard);
            this.addClickZone(new FlxPoint(400, 100), new FlxPoint(150, 150),
                null, postcardTouched);

            HouseMap.getInstance().playLoopingBGM(SndBGM, "overworld");

            this.postCreate();
        }

        override public function update():void
        {
            super.update();

            if (postcardTouchTime != -1){
                if (timeFrame > postcardTouchTime && timeFrame < postcardTouchTime+1*TimedState.fpSec) {
                    postcard.alpha += ALPHA_DELTA;
                }
            } else {
                postcard.alpha -= ALPHA_DELTA;
            }
            if (timeFrame > postcardTouchTime+4*TimedState.fpSec || FlxG.mouse.justPressed()) {
                player.shouldMove = true;
                postcardTouchTime = -1;
            }
        }

        private function postcardTouched(a:FlxSprite, b:FlxSprite):void
        {
            if (postcardTouchTime == -1) {
                postcardTouchTime = timeFrame;
                player.shouldMove = false;
            }
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
