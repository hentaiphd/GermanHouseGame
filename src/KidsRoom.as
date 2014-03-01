package
{
    import org.flixel.*;

    public class KidsRoom extends MapRoom
    {
        [Embed(source="../assets/05-BG-01.png")] private var ImgKidsRoom:Class;
        [Embed(source="../assets/05-Kasperle-02.png")] private var ImgKasperle1:Class;
        [Embed(source="../assets/05-Oma-01.png")] private var ImgOma1:Class;
        [Embed(source="../assets/05-Kid-01.png")] private var ImgKid1:Class;
        [Embed(source="../assets/05-Kid-02.png")] private var ImgKid2:Class;
        [Embed(source="../assets/05-Kid-03.png")] private var ImgKid3:Class;
        [Embed(source="../assets/05-Kid-04.png")] private var ImgKid4:Class;
        [Embed(source="../assets/05-Kid-05.png")] private var ImgKid5:Class;
        [Embed(source="../assets/Bubble-11.png")] private var ImgBubble11:Class;
        [Embed(source="../assets/Bubble-12.png")] private var ImgBubble12:Class;

        //german player version
        //barbeque - dog, boat, potassium, scanner, menu
        //peanut - house, shark, garage, pulp, beaker
        //curtains - printer, shelf, wallpaper, liquid, canary
        //chandelier - barcode, laser, comforter, outhouse, cot
        //asparagus - purse, skyscraper, guava, grapefruit, towel
        //bandana - banana, sherbet, alley, stool, ramp

        private var kasperle1:FlxSprite;
        private var oma1:FlxSprite;
        private var kid1:FlxSprite, kid2:FlxSprite, kid3:FlxSprite, kid4:FlxSprite, kid5:FlxSprite;
        private var bubble12:FlxSprite, bubble12Text1:FlxText;
        private var bubble11:FlxSprite, bubble11Text1:FlxText;

        private var bubble12String1:String, bubble12String1P2:String;
        private var bubble11String1:String;
        private var bubble12String2:String;

        private static const STATE_INTRO:int = 1;
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;
        private var currentState:int = STATE_INTRO;
        public var current_scene:Number = 0;

        private const ALPHA_DELTA:Number = .04;

        private static const SEL_QUES:String = "question_sel";

        override public function create():void
        {
            HouseMap.getInstance().KidsRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgKidsRoom);

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
            }

            if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                bubble12String1 = "Hello kids!";
                bubble12String1P2 = "Welcome to Kasperletheater";
                bubble11String1 = "HEEEEEEEEELLLLLLLLLLLLLLOOOOOOOOOOO!!!!!!!!!";
                bubble12String2 = "Well, dear kids, today we practice some German!";
            } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                bubble12String1 = "Hallo Kinder!";
                bubble12String1P2 = "Wir sind das Kasperletheater";
                bubble11String1 = "HAAAAAAAAALLLLLLLLLLLLLLOOOOOOOOOOO!!!!!!!!!";
                bubble12String2 = "So meine lieben Kinder, heute wird Englisch geübt!";
            }

            kasperle1 = new FlxSprite(154, 96);
            kasperle1.loadGraphic(ImgKasperle1, true, true, 152, 165, true);
            add(kasperle1);

            oma1 = new FlxSprite(317, 105);
            oma1.loadGraphic(ImgOma1, true, true, 168, 155, true);
            add(oma1);

            kid4 = new FlxSprite(16, 352);
            kid4.loadGraphic(ImgKid4, true, true, 110, 126, true);
            add(kid4);

            kid5 = new FlxSprite(135, 364);
            kid5.loadGraphic(ImgKid5, true, true, 100, 114, true);
            add(kid5);

            kid3 = new FlxSprite(248, 364);
            kid3.loadGraphic(ImgKid3, true, true, 124, 114, true);
            add(kid3);

            kid1 = new FlxSprite(378, 373);
            kid1.loadGraphic(ImgKid1, true, true, 114, 104, true);
            add(kid1);

            kid2 = new FlxSprite(519, 375);
            kid2.loadGraphic(ImgKid1, true, true, 109, 102, true);
            add(kid2);

            bubble12 = new FlxSprite(32, 214);
            bubble12.loadGraphic(ImgBubble12, true, true, 573, 123, true);
            add(bubble12);
            bubble12Text1 = new TextBox(new FlxPoint(bubble12.x+20, bubble12.y+20),
                                        new FlxPoint(bubble12.width, bubble12.height),
                                        bubble12String1);
            bubble12Text1.alpha = 0;
            add(bubble12Text1);

            bubble11 = new FlxSprite(5, 234);
            bubble11.loadGraphic(ImgBubble11, true, true, 626, 139, true);
            add(bubble11);
            bubble11Text1 = new TextBox(new FlxPoint(bubble11.x+20, bubble11.y+20),
                                        new FlxPoint(bubble11.width, bubble11.height),
                                        bubble11String1);
            bubble11Text1.alpha = 0;
            add(bubble11Text1);
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
