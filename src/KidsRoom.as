package
{
    import org.flixel.*;

    public class KidsRoom extends MapRoom
    {
        [Embed(source="../assets/05-BG-01.png")] private var ImgKidsRoom:Class;
        [Embed(source="../assets/05-Kasperle-01.png")] private var ImgKasperle1:Class;
        [Embed(source="../assets/05-Kasperle-02.png")] private var ImgKasperle2:Class;
        [Embed(source="../assets/05-Oma-01.png")] private var ImgOma1:Class;
        [Embed(source="../assets/05-Oma-02.png")] private var ImgOma2:Class;
        [Embed(source="../assets/05-Kid-01.png")] private var ImgKid1:Class;
        [Embed(source="../assets/05-Kid-02.png")] private var ImgKid2:Class;
        [Embed(source="../assets/05-Kid-03.png")] private var ImgKid3:Class;
        [Embed(source="../assets/05-Kid-04.png")] private var ImgKid4:Class;
        [Embed(source="../assets/05-Kid-05.png")] private var ImgKid5:Class;
        [Embed(source="../assets/05-Thing-01.png")] private var ImgThing1:Class;
        [Embed(source="../assets/05-Thing-02.png")] private var ImgThing2:Class;
        [Embed(source="../assets/05-Thing-03.png")] private var ImgThing3:Class;
        [Embed(source="../assets/05-Thing-04.png")] private var ImgThing4:Class;
        [Embed(source="../assets/05-Thing-05.png")] private var ImgThing5:Class;
        [Embed(source="../assets/05-Thing-06.png")] private var ImgThing6:Class;
        [Embed(source="../assets/Bubble-11.png")] private var ImgBubble11:Class;
        [Embed(source="../assets/Bubble-12.png")] private var ImgBubble12:Class;

        //german player version
        //barbeque - dog, boat, potassium, scanner, menu
        //peanut - house, shark, garage, pulp, beaker
        //curtains - printer, shelf, wallpaper, liquid, canary
        //chandelier - barcode, laser, comforter, outhouse, cot
        //asparagus - purse, skyscraper, guava, grapefruit, towel
        //bandana - banana, sherbet, alley, stool, ramp

        private var kasperle1:FlxSprite, kasperle2:FlxSprite;
        private var oma1:FlxSprite, oma2:FlxSprite;
        private var kid1:FlxSprite, kid2:FlxSprite, kid3:FlxSprite, kid4:FlxSprite, kid5:FlxSprite;
        private var bubble12:FlxSprite, bubble12Text1:FlxText;
        private var bubble12Text2:FlxText;
        private var bubble12Text3:FlxText;
        private var bubble11:FlxSprite, bubble11Text1:FlxText;

        private var bubble12String1:String, bubble12String1P2:String;
        private var bubble11String1:String;
        private var bubble12String2:String;
        private var bubble12String3:String;
        private var bubble12String3B:String;
        private var bubble12String3C:String;
        private var bubble12String3D:String;

        private static const STATE_INTRO:int = 1;
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;
        private var currentState:int = STATE_INTRO;
        public var current_scene:Number = 0;

        private const ALPHA_DELTA:Number = .04;

        private static const SEL_QUES:String = "question_sel";

        private static var guessOptions:Array;
        private var thisGuess:KidsGuess;

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

            guessOptions = new Array(
                new KidsGuess(ImgThing1, new FlxPoint(246, 64), new FlxPoint(126, 125),
                    new Array("Preisschild", "Kronleuchter", "Gartenhaus",
                              "Taschenlampe", "Mantel", "Katzenfutter"),
                    new Array("barcode", "chandelier", "laser", "comforter", "outhouse", "cot"),
                    1),
                new KidsGuess(ImgThing2, new FlxPoint(251, 65), new FlxPoint(99, 104),
                    new Array("Grill", "Hund", "Boot", "Kalium", "Fotoapparat", "Menü"),
                    new Array("barbeque", "dog", "boat", "potassium", "scanner", "menu"),
                    0),
                new KidsGuess(ImgThing3, new FlxPoint(261, 89), new FlxPoint(93, 73),
                    new Array("Haus", "Hai", "Garage", "Fruchtfleisch", "Erdnuss", "Becher"),
                    new Array("house", "shark", "garage", "pulp", "peanut", "beaker"),
                    4),
                new KidsGuess(ImgThing4, new FlxPoint(231, 63), new FlxPoint(139, 114),
                    new Array("Drucker", "Regal", "Tapete", "Flüssigkeit", "Kanarienvogel", "Vorhänge"),
                    new Array("printer", "shelf", "wallpaper", "liquid", "canary", "curtains"),
                    5),
                new KidsGuess(ImgThing5, new FlxPoint(252, 76), new FlxPoint(109, 150),
                    new Array("Geldbeutel", "Wolkenkratzer", "Guave", "Spargel", "Pampelmuse", "Handtuch"),
                    new Array("purse", "skyscraper", "guava", "asparagus", "grapefruit", "towel"),
                    5),
                new KidsGuess(ImgThing6, new FlxPoint(252, 76), new FlxPoint(112, 138),
                    new Array("Banane", "Sorbet", "Kopftuch", "Gasse", "Hocker", "Rampe"),
                    new Array("banana", "sherbet", "bandana", "alley", "stool", "ramp"),
                    5)
            );
            thisGuess = guessOptions[Math.floor(Math.random() * guessOptions.length)];
            thisGuess.alpha = 0;
            add(thisGuess);

            var options:Array;

            if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                bubble12String1 = "Hello kids!";
                bubble12String1P2 = "Welcome to Kasperletheater!";
                bubble11String1 = "HEEEEEEEEELLLLLLLLLLLLLLOOOOOOOOOOO!!!!!!!!!";
                bubble12String2 = "Well, dear kids, today we practice some German!";
                options = thisGuess.choices_de;
                bubble12String3 = "You made a good guess, but who knows if it’s true!";
                bubble12String3B = "Does it even matter to any of you?";
                bubble12String3C = "We recommend that you now go out…";
                bubble12String3D = "…and discover what Deutsches Haus’s all about!";
            } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                bubble12String1 = "Hallo Kinder!";
                bubble12String1P2 = "Wir sind das Kasperletheater!";
                bubble11String1 = "HAAAAAAAAALLLLLLLLLLLLLLOOOOOOOOOOO!!!!!!!!!";
                bubble12String2 = "So meine lieben Kinder, heute wird Englisch geübt!";
                options = thisGuess.choices_en;
                bubble12String3 = "Da warn schon sehr gute Vorschläge dabei!";
                bubble12String3B = "Aber ob einer stimmt, ist doch einerlei.";
                bubble12String3C = "Ihr solltet jetzt wieder weiter gehn…";
                bubble12String3D = "… und euch noch mehr im Deutschen Haus umsehn.";
            }

            kasperle2 = new FlxSprite(154, 96);
            kasperle2.loadGraphic(ImgKasperle2, true, true, 152, 165, true);
            add(kasperle2);

            oma1 = new FlxSprite(317, 105);
            oma1.loadGraphic(ImgOma1, true, true, 168, 155, true);
            add(oma1);

            kasperle1 = new FlxSprite(135, 156);
            kasperle1.loadGraphic(ImgKasperle1, true, true, 105, 106, true);
            kasperle1.alpha = 0;
            add(kasperle1);

            oma2 = new FlxSprite(397, 177);
            oma2.loadGraphic(ImgOma2, true, true, 126, 79, true);
            oma2.alpha = 0;
            add(oma2);

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
            bubble12.alpha = 0;
            add(bubble12);
            bubble12Text1 = new TextBox(new FlxPoint(bubble12.x+10, bubble12.y+50),
                                        new FlxPoint(bubble12.width-20, bubble12.height-50),
                                        bubble12String1, "center");
            bubble12Text1.alpha = 0;
            add(bubble12Text1);

            bubble12Text2 = new TextBox(new FlxPoint(bubble12.x+10, bubble12.y+50),
                                        new FlxPoint(bubble12.width-20, bubble12.height-50),
                                        bubble12String2, "center");
            bubble12Text2.alpha = 0;
            add(bubble12Text2);

            bubble12Text3 = new TextBox(new FlxPoint(bubble12.x+10, bubble12.y+50),
                                        new FlxPoint(bubble12.width-20, bubble12.height-50),
                                        bubble12String3, "center");
            bubble12Text3.alpha = 0;
            add(bubble12Text3);

            bubble11 = new FlxSprite(5, 234);
            bubble11.loadGraphic(ImgBubble11, true, true, 626, 139, true);
            bubble11.alpha = 0;
            add(bubble11);
            bubble11Text1 = new TextBox(new FlxPoint(bubble11.x+20, bubble11.y+40),
                                        new FlxPoint(bubble11.width, bubble11.height-60),
                                        bubble11String1, "center");
            bubble11Text1.alpha = 0;
            add(bubble11Text1);

            conversation(new FlxPoint(bubble11.x+30, bubble11.y+30),
                         new FlxPoint(bubble11.width, bubble11.height),
                         "", this, SEL_QUES, options, true, 25, null)();

            debugText = new FlxText(100,100,FlxG.width,"");
            debugText.color = 0xff000000;
        }

        override public function update():void{
            super.update();

            if (currentState == STATE_INTRO) {
                if (current_scene == 0 && timeFrame == 1) {
                    current_scene += 1;
                } else if (current_scene == 1 && timeFrame == 2*TimedState.fpSec) {
                    current_scene += 1;
                    bubble12Text1.text += " " + bubble12String1P2;
                } else if (current_scene == 2 && timeFrame == 4*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == 6*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 4 && timeFrame == 8*TimedState.fpSec) {
                    current_scene = 1;
                    currentState = STATE_CHOICE;
                    lastStateChangeTimeFrame = timeFrame;
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+2*TimedState.fpSec) {
                    current_scene += 1;
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+2*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 2 && timeFrame == lastStateChangeTimeFrame+4*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == lastStateChangeTimeFrame+6*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 4 && timeFrame == lastStateChangeTimeFrame+8*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 5 && timeFrame == lastStateChangeTimeFrame+10*TimedState.fpSec) {
                    FlxG.switchState(new UpstairsRoom());
                }
            }

            if (currentState == STATE_INTRO) {
                if (current_scene == 1) {
                    bubble12.alpha += ALPHA_DELTA;
                    bubble12Text1.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {

                } else if (current_scene == 3) {
                    bubble12.alpha -= ALPHA_DELTA;
                    bubble12Text1.alpha -= ALPHA_DELTA;
                    bubble11.alpha += ALPHA_DELTA;
                    bubble11Text1.alpha += ALPHA_DELTA;
                } else if (current_scene == 4) {
                    bubble12.alpha += ALPHA_DELTA;
                    bubble12Text2.alpha += ALPHA_DELTA;
                    bubble11.alpha -= ALPHA_DELTA;
                    bubble11Text1.alpha -= ALPHA_DELTA;
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1) {
                    bubble12.alpha -= ALPHA_DELTA;
                    bubble12Text2.alpha -= ALPHA_DELTA;
                    oma1.alpha -= ALPHA_DELTA;
                    oma2.alpha += ALPHA_DELTA;
                    kasperle1.alpha += ALPHA_DELTA;
                    kasperle2.alpha -= ALPHA_DELTA;
                    thisGuess.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {
                    bubble11.alpha += ALPHA_DELTA;
                    this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1) {
                    bubble11.alpha -= ALPHA_DELTA;
                    this.activeSelectorBox.incrementAlpha(-ALPHA_DELTA);
                    oma1.alpha += ALPHA_DELTA;
                    oma2.alpha -= ALPHA_DELTA;
                    kasperle1.alpha -= ALPHA_DELTA;
                    kasperle2.alpha += ALPHA_DELTA;
                    bubble12.alpha += ALPHA_DELTA;
                    bubble12Text3.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {
                    bubble12Text3.text = bubble12String3B;
                } else if (current_scene == 3) {
                    bubble12Text3.text = bubble12String3C;
                } else if (current_scene == 4) {
                    bubble12Text3.text = bubble12String3D;
                }
            }
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_CHOICE && current_scene == 2
                && selector._label == SEL_QUES)
            {
                current_scene = 1;
                currentState = STATE_RESULT;
                lastSelectionTimeFrame = timeFrame;
                lastStateChangeTimeFrame = timeFrame;

                if (idx == thisGuess.correct_idx) {

                } else {

                }
            }
        }
    }
}
