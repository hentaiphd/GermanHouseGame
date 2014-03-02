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
        [Embed(source="../assets/05-Dad-01.png")] private var ImgDad:Class;
        [Embed(source="../assets/05-Mom-01.png")] private var ImgMom:Class;
        [Embed(source="../assets/Bubble-02.png")] private var ImgBubble2:Class;
        [Embed(source="../assets/Bubble-11.png")] private var ImgBubble11:Class;
        [Embed(source="../assets/Bubble-12.png")] private var ImgBubble12:Class;
        [Embed(source="../assets/kids.mp3")] private var SndBGM:Class;

        private var kasperle1:FlxSprite, kasperle2:FlxSprite;
        private var oma1:FlxSprite, oma2:FlxSprite;
        private var mom:FlxSprite, dad:FlxSprite;
        private var kid1:FlxSprite, kid2:FlxSprite, kid3:FlxSprite, kid4:FlxSprite, kid5:FlxSprite;
        private var bubble2:FlxSprite, bubble2Text:FlxText;
        private var bubble12:FlxSprite, bubble12Text1:FlxText;
        private var bubble12Text2:FlxText;
        private var bubble12Text3:FlxText;
        private var bubble11:FlxSprite, bubble11Text1:FlxText;

        private var bubble2String1:String;
        private var bubble12String1:String, bubble12String1P2:String;
        private var bubble11String1:String;
        private var bubble12String2:String;
        private var bubble12String3:String;
        private var bubble12String3B:String;
        private var bubble12String3C:String;
        private var bubble12String3D:String;
        private var bubble12String4:String;
        private var bubble12String4B:String;
        private var bubble12String5:String;
        private var guessCorrectString:String, guessIncorrectString:String;

        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;

        private static const GUESS_CORRECT:int = 69;
        private static const GUESS_INCORRECT:int = 420;
        private var guessResult:int = GUESS_INCORRECT;

        private static const SEL_QUES:String = "question_sel";

        private static var guessOptions:Array;
        private var thisGuess:KidsGuess;
        private var options:Array;


        override public function create():void
        {
            HouseMap.getInstance().KidsRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgKidsRoom);

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

            this.switchLanguage();

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
            kid2.loadGraphic(ImgKid2, true, true, 109, 102, true);
            add(kid2);

            mom = new FlxSprite(-81, 75);
            mom.loadGraphic(ImgMom, true, true, 381, 450, true);
            mom.alpha = 0;
            add(mom);

            dad = new FlxSprite(330, 68);
            dad.loadGraphic(ImgDad, true, true, 395, 433, true);
            dad.alpha = 0;
            add(dad);

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

            bubble2 = new FlxSprite(107, 214);
            bubble2.loadGraphic(ImgBubble2, true, true, 329, 144, true);
            bubble2.alpha = 0;
            add(bubble2);
            bubble2Text = new TextBox(new FlxPoint(bubble2.x+20, bubble2.y+40),
                                      new FlxPoint(bubble2.width, bubble2.height-60),
                                      bubble2String1, "center");
            bubble2Text.alpha = 0;
            add(bubble2Text);

            conversation(new FlxPoint(bubble11.x+30, bubble11.y),
                         new FlxPoint(bubble11.width, bubble11.height),
                         "", this, SEL_QUES, options, true, 25, null,
                         new Array(new FlxPoint(30, 20), new FlxPoint(208, 23),
                                   new FlxPoint(393, 23), new FlxPoint(93, 58),
                                   new FlxPoint(319, 55), new FlxPoint(459, 56))
                        )();

            CONFIG::debugging {
                debugText = new FlxText(100,100,FlxG.width,"");
                debugText.color = 0xff000000;
                add(debugText);
            }

            HouseMap.getInstance().playLoopingBGM(SndBGM, "kids");
        }

        override public function switchLanguage():void
        {
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
                bubble12String4 = "Not you, darling! This game has come to an end…";
                bubble12String4B = "…because you found your parents!";
                bubble2String1 = "Mom and Dad!";
                guessCorrectString = "Yes, Kid, it’s us! And, by the way, you were right:";
                guessIncorrectString = "Yes, Kid, it’s us! And, by the way, you were wrong:";
                bubble12String5 = "This thing is called " + thisGuess.choices_de[thisGuess.correct_idx] + ". Now let's go home.";
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
                bubble12String4 = "Du musst aber nicht gehen, denn du bist jetzt am Ziel…";
                bubble12String4B = "…wir Eltern haben die Puppen gespielt!";
                bubble2String1 = "Mama und Papa!";
                guessCorrectString = "Du hast und gefunden! Und du hattest übrigens recht:";
                guessIncorrectString = "Du hast und gefunden! Und du lagst übrigens falsch:";
                bubble12String5 = "Diese Sache heißt " + thisGuess.choices_en[thisGuess.correct_idx] + ". Und jetzt gehn wir heim!";
            }
        }

        override public function update():void{
            super.update();

            CONFIG::debugging {
                debugText.text = current_scene + "";
            }

            if (currentState == STATE_INTRO) {
                if (current_scene == 0 && timeFrame == 1) {
                    current_scene += 1;
                } else if (current_scene == 1 && startAgo(2)) {
                    current_scene += 1;
                    bubble12Text1.text += " " + bubble12String1P2;
                } else if (current_scene == 2 && startAgo(4)) {
                    current_scene += 1;
                } else if (current_scene == 3 && startAgo(6)) {
                    current_scene += 1;
                } else if (current_scene == 4 && startAgo(8)) {
                    current_scene = 1;
                    switchState(STATE_CHOICE);
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1 && lastStateAgo(2)) {
                    current_scene += 1;
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1 && lastStateAgo(2)) {
                    current_scene += 1;
                } else if (current_scene == 2 && lastStateAgo(4)) {
                    current_scene += 1;
                } else if (current_scene == 3 && lastStateAgo(6)) {
                    current_scene += 1;
                } else if (current_scene == 4 && lastStateAgo(8)) {
                    current_scene += 1;
                    if (!this.ending) {
                        FlxG.switchState(new UpstairsRoom());
                    } else if (this.ending){
                        this.theEnd();
                    }
                } else if (current_scene == 5) {
                    if (lastStateAgo(10)) {
                        current_scene += 1;
                        bubble12Text3.text = bubble12String4;
                    }
                } else if (current_scene == 6 && lastStateAgo(14)) {
                    current_scene += 1;
                    bubble12Text3.text = bubble12String4B;
                } else if (current_scene == 7 && lastStateAgo(16)) {
                    current_scene += 1;
                } else if (current_scene == 8 && lastStateAgo(17)) {
                    current_scene += 1;
                    if (guessResult == GUESS_CORRECT) {
                        bubble12Text3.text = guessCorrectString;
                    } else if (guessResult == GUESS_INCORRECT) {
                        bubble12Text3.text = guessIncorrectString;
                    }
                } else if (current_scene == 9 && lastStateAgo(19)) {
                    current_scene += 1;
                    bubble12Text3.text = bubble12String5;
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
                } else if (current_scene == 5) {
                    kid2.alpha -= ALPHA_DELTA;
                    kid3.alpha -= ALPHA_DELTA;
                    kid4.alpha -= ALPHA_DELTA;
                    kid5.alpha -= ALPHA_DELTA;
                    kasperle2.alpha -= ALPHA_DELTA;
                    oma1.alpha -= ALPHA_DELTA;
                    bubble12.alpha -= ALPHA_DELTA;
                    bubble12Text3.alpha -= ALPHA_DELTA;
                    mom.alpha += ALPHA_DELTA;
                    dad.alpha += ALPHA_DELTA;
                } else if (current_scene == 6) {
                    bubble12.alpha += ALPHA_DELTA;
                    bubble12Text3.alpha += ALPHA_DELTA;
                } else if (current_scene == 7) {
                } else if (current_scene == 8) {
                    bubble12.alpha -= ALPHA_DELTA;
                    bubble12Text3.alpha -= ALPHA_DELTA;
                    bubble2.alpha += ALPHA_DELTA;
                    bubble2Text.alpha += ALPHA_DELTA;
                } else if (current_scene == 9) {
                    bubble12.alpha += ALPHA_DELTA;
                    bubble12Text3.alpha += ALPHA_DELTA;
                    bubble2.alpha -= ALPHA_DELTA;
                    bubble2Text.alpha -= ALPHA_DELTA;
                } else if (current_scene == 10) {

                }
            }
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_CHOICE && current_scene == 2
                && selector._label == SEL_QUES)
            {
                switchState(STATE_RESULT);
                lastSelectionTimeFrame = timeFrame;

                if (idx == thisGuess.correct_idx) {
                    guessResult = GUESS_CORRECT;
                } else {
                    guessResult = GUESS_INCORRECT;
                }
            }
        }
    }
}
