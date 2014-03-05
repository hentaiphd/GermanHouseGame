package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/0201-BG.png")] private var ImgBG:Class;
        [Embed(source="../assets/02-BG-1.png")] private var ImgBGOffer:Class;
        [Embed(source="../assets/02-BG-3.png")] private var ImgBGOfferEnd:Class;
        [Embed(source="../assets/02-BG-2.png")] private var ImgBGResult:Class;
        [Embed(source="../assets/02-BG-4.png")] private var ImgBGResultEnd:Class;
        [Embed(source="../assets/0202-Photographer.png")] private var ImgPhotographer:Class;
        [Embed(source="../assets/0203-Friseurin.png")] private var ImgFriseurin:Class;
        [Embed(source="../assets/0204-Kid.png")] private var ImgKid1:Class;
        [Embed(source="../assets/0204-Kid-1.png")] private var ImgKid2:Class;
        [Embed(source="../assets/02-Kid-2.png")] private var ImgKid3:Class;
        [Embed(source="../assets/02-Kid-3.png")] private var ImgKid4:Class;
        [Embed(source="../assets/02-Kid-4.png")] private var ImgKid5:Class;
        [Embed(source="../assets/02-Kid-5.png")] private var ImgKid6:Class;
        [Embed(source="../assets/Bubble-04.png")] private var ImgKidBubble1:Class;
        [Embed(source="../assets/Bubble-05.png")] private var ImgFriseurBubble1:Class;
        [Embed(source="../assets/Bubble-06.png")] private var ImgPhotographerBubble1:Class;
        [Embed(source="../assets/Bubble-07.png")] private var ImgOfferBubble1:Class;
        [Embed(source="../assets/Bubble-08.png")] private var ImgOfferBubble2:Class;
        [Embed(source="../assets/Bubble-14.png")] private var ImgBubble14:Class;
        [Embed(source="../assets/Bubble-15.png")] private var ImgBubble15:Class;
        [Embed(source="../assets/Bubble-16.png")] private var ImgBubble16:Class;
        [Embed(source="../assets/02-Customer-1.png")] private var ImgCustomer1:Class;
        [Embed(source="../assets/02-Customer-2.png")] private var ImgCustomer2:Class;
        [Embed(source="../assets/02-Customer-3.png")] private var ImgCustomer3:Class;
        [Embed(source="../assets/02-Scissors-01.png")] private var ImgScissors1:Class;
        [Embed(source="../assets/02-Scissors-02.png")] private var ImgScissors2:Class;
        [Embed(source="../assets/02-Scissors-03.png")] private var ImgScissors3:Class;
        [Embed(source="../assets/culture.mp3")] private var SndBGM:Class;
        [Embed(source="../assets/barber1.mp3")] private var SndFriseur:Class;
        [Embed(source="../assets/hairsounds.mp3")] private var SndHair:Class;
        [Embed(source="../assets/dooropen.mp3")] private var SndDoor:Class;

        private var photographer:FlxSprite;
        private var friseurin:FlxSprite;
        private var kid:FlxSprite;
        private var kid2:FlxSprite;
        private var kid3:FlxSprite;
        private var kidBubble1:FlxSprite;
        private var kidBubble1Text:FlxText;
        private var friseurBubble1:FlxSprite;
        private var friseurBubble1Text:FlxText;
        private var photographerBubble1:FlxSprite;
        private var photographerBubble1Text:FlxText;
        private var offerBackground:FlxSprite;
        private var offerBubble:FlxSprite;
        private var resultBackground:FlxSprite;
        private var customer:FlxSprite;
        private var resultBubble1:FlxSprite, resultText1:FlxText;
        private var resultBubble2:FlxSprite, resultText2:FlxText;
        private var bubble16:FlxSprite, bubble16Text:FlxText;
        private var bubble15:FlxSprite, bubble15Text:FlxText;
        private var bubble14:FlxSprite, bubble14Text:FlxText;
        private var endText2:String;
        private var cutOption1:FlxSprite, cutOption2:FlxSprite, cutOption3:FlxSprite;

        private var kidText1:String, kidText2:String, kidText2End:String, kidText3End:String,
            kidText4End:String;
        private var momText1:String, momText2:String, momText3:String;
        private var friseurText1:String,
            offerText:String, offerTextEnd:String, resultText:String, endText1:String,
            resultTextEnd:String, resultText1End:String, resultText2End:String,
            resultText3End:String;
        private var photographerText1:String, photographerText1B:String,
            photographerText1C:String,photographerText1D:String,photographerText1E:String;
        private var photographerText1End:String;
        private var offerChoices:Array = new Array();

        private static const CHOICE_SHORT:int = 1;
        private static const CHOICE_MED:int = 2;
        private static const CHOICE_LONG:int = 3;
        private var cutChoice:Number;

        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;

        private static const SEL_OFFER:String = "offer_sel";

        override public function create():void
        {
            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgBG);

            this.switchLanguage();

            CONFIG::debugging {
                this.ending = true;
            }

            photographer = new FlxSprite(34, 84);
            photographer.loadGraphic(ImgPhotographer, true, true, 992/4, 231, true);
            photographer.addAnimation("run", [0, 1, 2, 3, 0, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3], 12, true);
            add(photographer);
            photographer.play("run");

            friseurin = new FlxSprite(306, 31);
            friseurin.loadGraphic(ImgFriseurin, true, true, 1560/5, 291, true);
            friseurin.addAnimation("run", [1, 2, 3, 4, 0, 0, 0, 0, 0, 0], 12, true);
            add(friseurin);
            friseurin.play("run");

            kid = new FlxSprite(248, 342);
            kid.loadGraphic(ImgKid1, true, true, 130, 133, true);
            add(kid);

            kid2 = new FlxSprite(248, 342);
            kid2.loadGraphic(ImgKid2, true, true, 130, 133, true);
            kid2.alpha = 0;
            add(kid2);

            friseurBubble1 = new FlxSprite(390, 308);
            friseurBubble1.loadGraphic(ImgFriseurBubble1, true, true, 236, 160, true);
            friseurBubble1.alpha = 0;
            add(friseurBubble1);
            friseurBubble1Text = new TextBox(new FlxPoint(friseurBubble1.x+10, friseurBubble1.y+40),
                                             new FlxPoint(friseurBubble1.width-20, friseurBubble1.height),
                                             friseurText1);
            friseurBubble1Text.alpha = 0;
            add(friseurBubble1Text);

            photographerBubble1 = new FlxSprite(10, 307);
            photographerBubble1.loadGraphic(ImgPhotographerBubble1, true, true, 236, 160, true);
            photographerBubble1.alpha = 0;
            add(photographerBubble1);
            var photogString:String = photographerText1;
            if (this.ending) {
                photogString = photographerText1End;
            }
            photographerBubble1Text = new TextBox(new FlxPoint(photographerBubble1.x+10, photographerBubble1.y+40),
                                             new FlxPoint(photographerBubble1.width-20, photographerBubble1.height),
                                             photogString);
            photographerBubble1Text.alpha = 0;
            add(photographerBubble1Text);

            offerBackground = new FlxSprite(0, 0);
            if (this.ending) {
                offerBackground.loadGraphic(ImgBGOfferEnd, true, true, 640, 480, true);
            } else {
                offerBackground.loadGraphic(ImgBGOffer, true, true, 640, 480, true);
            }
            offerBackground.alpha = 0;
            add(offerBackground);

            offerBubble = new FlxSprite(11, 10);
            offerBubble.loadGraphic(ImgOfferBubble1, true, true, 361, 457, true);
            offerBubble.alpha = 0;
            add(offerBubble);

            resultBackground = new FlxSprite(0, 0);
            if (this.ending) {
                resultBackground.loadGraphic(ImgBGResultEnd, true, true, 640, 480, true);
            } else {
                resultBackground.loadGraphic(ImgBGResult, true, true, 640, 480, true);
            }
            resultBackground.alpha = 0;
            add(resultBackground);

            customer = new FlxSprite(0, 0);
            customer.alpha = 0;
            add(customer);

            kid3 = new FlxSprite(26, 285);
            kid3.loadGraphic(ImgKid3, true, true, 228, 205, true);
            kid3.alpha = 0;
            add(kid3);

            resultBubble1 = new FlxSprite(57, 15);
            resultBubble1.loadGraphic(ImgOfferBubble2, true, true, 396, 75, true);
            resultBubble1.alpha = 0;
            add(resultBubble1);
            resultText1 = new TextBox(new FlxPoint(resultBubble1.x+10, resultBubble1.y+20),
                                             new FlxPoint(resultBubble1.width-20, resultBubble1.height),
                                             resultText);
            resultText1.alpha = 0;
            add(resultText1);

            resultBubble2 = new FlxSprite(393, 307);
            resultBubble2.loadGraphic(ImgPhotographerBubble1, true, true, 236, 160, true);
            resultBubble2.alpha = 0;
            add(resultBubble2);
            resultText2 = new TextBox(new FlxPoint(resultBubble2.x+10, resultBubble2.y+40),
                                             new FlxPoint(resultBubble2.width-20, resultBubble2.height),
                                             endText1);
            resultText2.alpha = 0;
            add(resultText2);

            bubble16 = new FlxSprite(338, 228);
            bubble16.loadGraphic(ImgBubble16, true, true, 280, 240, true);
            bubble16.alpha = 0;
            add(bubble16);
            bubble16Text = new TextBox(new FlxPoint(bubble16.x+60, bubble16.y+110),
                                       new FlxPoint(bubble16.width-60, bubble16.height),
                                       momText1);
            bubble16Text.alpha = 0;
            add(bubble16Text);

            bubble14 = new FlxSprite(46, 340);
            bubble14.loadGraphic(ImgBubble14, true, true, 564, 127, true);
            bubble14.alpha = 0;
            add(bubble14);
            bubble14Text = new TextBox(new FlxPoint(bubble14.x+10, bubble14.y+50),
                                       new FlxPoint(bubble14.width-20, bubble14.height),
                                       resultTextEnd);
            bubble14Text.alpha = 0;
            add(bubble14Text);

            bubble15 = new FlxSprite(131, 385);
            bubble15.loadGraphic(ImgBubble15, true, true, 396, 75, true);
            bubble15.alpha = 0;
            add(bubble15);
            bubble15Text = new TextBox(new FlxPoint(bubble15.x+10, bubble15.y+30),
                                       new FlxPoint(bubble15.width-20, bubble15.height),
                                       resultText1End);
            bubble15Text.alpha = 0;
            add(bubble15Text);

            kidBubble1 = new FlxSprite(374, 332);
            kidBubble1.loadGraphic(ImgKidBubble1, true, true, 254, 137, true);
            kidBubble1.alpha = 0;
            add(kidBubble1);
            kidBubble1Text = new TextBox(new FlxPoint(kidBubble1.x+30, kidBubble1.y+10),
                                         new FlxPoint(kidBubble1.width-40, kidBubble1.height),
                                         kidText1);
            kidBubble1Text.alpha = 0;
            add(kidBubble1Text);

            cutOption1 = new FlxSprite(0, 0);
            cutOption1.loadGraphic(ImgScissors1, true, true, 70, 76, true);

            cutOption2 = new FlxSprite(0, 0);
            cutOption2.loadGraphic(ImgScissors2, true, true, 70, 80, true);

            cutOption3 = new FlxSprite(0, 0);
            cutOption3.loadGraphic(ImgScissors3, true, true, 81, 108, true);

            var choiceImages:Array = new Array(cutOption1, cutOption2, cutOption3);

            var _offerText:String = offerText;
            if (this.ending) {
                _offerText = offerTextEnd;
            }
            conversation(new FlxPoint(offerBubble.x+40, offerBubble.y+30),
                         new FlxPoint(offerBubble.width-80, offerBubble.height),
                         _offerText, this, SEL_OFFER, offerChoices, true, 120, choiceImages)();

            CONFIG::debugging {
                debugText = new FlxText(300,10,300,"");
                debugText.color = 0xff000000;
                debugText.size = 11;
                add(debugText);
            }

            HouseMap.getInstance().playLoopingBGM(SndBGM, "culture");

            FlxG.play(SndHair, .4, true);
            FlxG.play(SndDoor);

            this.postCreate();
        }

        override public function switchLanguage():void
        {
            if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                kidText1 = "What are you doing?";
                friseurText1 = "I'm cutting her hair!";
                photographerText1 = "I'm a photographer as you can see.";
                photographerText1B = "See the photos in the back?";
                photographerText1C = "That’s my exhibition.";
                photographerText1D = "I’m taking photos of hair cutting performances!";
                photographerText1E = "We’re the cultural program, you know!";
                photographerText1End = "I’m taking photos of hair cutting performances!";
                kidText2 = "OK.";
                kidText2End = "Mom,is that you?";
                momText1 = "Yes! I’m part of the performance!";
                kidText3End = "And where is dad?";
                momText2 = "He’s here in the picture. He had his hair cut already!";
                momText3 = "And now, it’s your turn!";
                kidText4End = "What?";
                offerText = "You wanna try for yourself, sweetie?";
                offerTextEnd = "Ok, sweetie, how much do you want me to cut off?";
                offerChoices = new Array("Cut a little", "Cut something", "Cut a lot");
                resultText = "That's not bad, kid!";
                if (Math.floor(Math.random()*2) == 0) {
                    resultTextEnd = "You look so handsome! Thank you very much!";
                } else {
                    resultTextEnd = "You look so pretty! Thank you very much!";
                }
                resultText1End = "It was my pleasure!";
                resultText2End = "I’ve learned so much and it was really fun!";
                resultText3End = "I’ll come back tomorrow, that’s for sure.";
                endText1 = "But your parents are not here, at the cultural program.";
                endText2 = "You will have to find them in another part of Deutsches Haus.";
            } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                kidText1 = "Was machst du denn da?";
                friseurText1 = "Ich verpass ihr einen hippen Haarschnitt!";
                photographerText1 = "Ich bin Fotograf, wie du siehst!";
                photographerText1B = "Siehst du die Bilder an der Wand?";
                photographerText1C = "Das ist eine Ausstellung von mir.";
                photographerText1D = "Ich fotografiere Performances übers Haareschneiden!";
                photographerText1E = "Wir sind hier das Cultural Program, verstehst du!";
                photographerText1End = "Ich fotografiere Performances übers Haareschneiden!";
                kidText2 = "Verstehe.";
                kidText2End = "Bist du das Mama?";
                momText1 = "Ja, ich mach mit, bei der Performance!";
                kidText3End = "Und wo ist der Papa?";
                momText2 = "Er ist hier, auf dem Foto. Er hat einen neuen Haarschnitt bekommen!";
                momText3 = "Und jetzt bist du dran!";
                kidText4End = "Wie bitte?";
                offerText = "Willstes mal selber probieren?";
                offerTextEnd = "Du hast es ja gehört, wie viel soll ich dir abschneiden?";
                offerChoices = new Array("Wenig abschneiden", "Etwas abschneiden", "Viel abschneiden");
                resultText = "Wow! Gar nicht schlecht ist das!";
                resultTextEnd = "Das sieht ja super aus! Tausend Dank!";
                resultText1End = "Da nich für! War mir eine Ehre.";
                resultText2End = "Ich hab viel gelernt heute, das war echt lustig.";
                resultText3End = "Morgen komme ich auf jeden Fall wieder!";
                endText1 = "Aber deine Eltern sind leider nicht hier, im Kulturprogramm!";
                endText2 = "Die müssen irgendwo anders im Deutschen Haus sein.";
            }
        }

        override public function update():void{
            super.update();

            CONFIG::debugging {
                debugText.text = "" + activeSprites.length;
            }

            if (!this.ending) {
                if (currentState == STATE_INTRO) {
                    if (current_scene == 0 && timeFrame == 1) {
                        makeActive(kidBubble1, kidBubble1Text);
                        this.incrementScene();
                    } else if (current_scene == 1 && shouldAdvanceScene(2)) {
                        makeInactive(kidBubble1, kidBubble1Text, kid);
                        makeActive(photographerBubble1, photographerBubble1Text, kid2);
                        this.incrementScene();
                    } else if (current_scene == 2 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                    } else if (current_scene == 3 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1B;
                    } else if (current_scene == 4 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1C;
                    } else if (current_scene == 5 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1D;
                    } else if (current_scene == 6 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1E;
                    } else if (current_scene == 7 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        kidBubble1Text.text = kidText2;
                        makeActive(kidBubble1, kidBubble1Text);
                        makeInactive(photographerBubble1, photographerBubble1Text);
                    } else if (current_scene == 8 && shouldAdvanceScene(2)) {
                        switchState(STATE_CHOICE);
                        makeInactive(bgImage, kid2, friseurin, photographer, photographerBubble1, photographerBubble1Text, kidBubble1, kidBubble1Text);
                        makeActive(offerBackground, offerBubble);
                    }
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 1 && shouldAdvanceScene(1)) {
                        this.incrementScene();
                        FlxG.play(SndFriseur);
                    } else if (current_scene == 2) {
                    } else if (current_scene == 3 && shouldAdvanceScene(1)) {
                        switchState(STATE_RESULT);
                        makeInactive(offerBubble, offerBackground);
                        makeActive(resultBackground, kid3, customer);
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1 && shouldAdvanceScene(3)) {
                        this.incrementScene();
                        makeActive(resultBubble1, resultText1);
                    } else if (current_scene == 2 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        makeInactive(resultBubble1, resultText1);
                        makeActive(resultBubble2, resultText2);
                    } else if (current_scene == 3 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        resultText2.text = endText2;
                    } else if (current_scene == 4 && shouldAdvanceScene(3)) {
                        this.incrementScene();
                        FlxG.switchState(new LobbyRoom());
                    }
                }

                if (currentState == STATE_INTRO) {
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 2) {
                        this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1) {
                        this.activeSelectorBox.incrementAlpha(-ALPHA_DELTA);
                    }
                }
            } else {  // ending
                if (currentState == STATE_INTRO) {
                    if (current_scene == 0 && timeFrame == 1) {
                        this.incrementScene();
                        makeActive(kidBubble1, kidBubble1Text);
                    } else if (current_scene == 1 && shouldAdvanceScene(2)) {
                        makeInactive(kidBubble1, kidBubble1Text, kid);
                        makeActive(photographerBubble1, photographerBubble1Text, kid2);
                        this.incrementScene();
                    } else if (current_scene == 2 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        makeInactive(photographerBubble1, photographerBubble1Text);
                        makeActive(kidBubble1, kidBubble1Text);
                        kidBubble1Text.text = kidText2End;
                    } else if (current_scene == 3 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        makeActive(bubble16, bubble16Text);
                        makeInactive(kidBubble1, kidBubble1Text);
                    } else if (current_scene == 4 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        makeActive(kidBubble1, kidBubble1Text);
                        makeInactive(bubble16, bubble16Text);
                        kidBubble1Text.text = kidText3End;
                    } else if (current_scene == 5 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        bubble16Text.text = momText2;
                        makeInactive(kidBubble1, kidBubble1Text);
                        makeActive(bubble16, bubble16Text);
                    } else if (current_scene == 6 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1;
                        makeInactive(bubble16, bubble16Text);
                        makeActive(photographerBubble1, photographerBubble1Text);
                    } else if (current_scene == 7 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1B;
                    } else if (current_scene == 8 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1C;
                    } else if (current_scene == 9 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        photographerBubble1Text.text = photographerText1E;
                    } else if (current_scene == 10 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                    } else if (current_scene == 11 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        bubble16Text.text = momText3;
                        makeActive(bubble16, bubble16Text);
                        makeInactive(photographerBubble1, photographerBubble1Text);
                    } else if (current_scene == 12 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        kidBubble1Text.text = kidText4End;
                        makeInactive(bubble16, bubble16Text);
                        makeActive(kidBubble1, kidBubble1Text);
                    } else if (current_scene == 13 && shouldAdvanceScene(2)) {
                        switchState(STATE_CHOICE);
                        makeInactive(bgImage, kid2, friseurin, photographer, kidBubble1, kidBubble1Text);
                        makeActive(offerBackground, offerBubble);
                    }
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 1 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        FlxG.play(SndFriseur);
                    } else if (current_scene == 2) {
                    } else if (current_scene == 3 && shouldAdvanceScene(1)) {
                        switchState(STATE_RESULT);
                        makeInactive(offerBubble, offerBackground);
                        makeActive(resultBackground, customer);
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        makeActive(bubble14, bubble14Text);
                    } else if(current_scene == 2 && shouldAdvanceScene(4)) {
                        this.incrementScene();
                        makeInactive(bubble14, bubble14Text);
                        makeActive(bubble15, bubble15Text);
                    } else if(current_scene == 3 && shouldAdvanceScene(6)) {
                        this.incrementScene();
                        kidBubble1Text.text = resultText2End;
                        makeInactive(bubble15, bubble15Text);
                        makeActive(kidBubble1, kidBubble1Text);
                    } else if(current_scene == 4 && shouldAdvanceScene(8)) {
                        this.incrementScene();
                        kidBubble1Text.text = resultText3End;
                    } else if(current_scene == 5 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                        this.theEnd();
                    } else if(current_scene == 6 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                    } else if(current_scene == 7 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                    } else if(current_scene == 8 && shouldAdvanceScene(2)) {
                        this.incrementScene();
                    }
                }

                if (currentState == STATE_INTRO) {
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 2) {
                        this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1) {
                        this.activeSelectorBox.incrementAlpha(-ALPHA_DELTA);
                    }
                }
            }
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_CHOICE && current_scene == 2
                && selector._label == SEL_OFFER)
            {
                super.didSelectTextOption(idx, item, selector);
                lastSelectionTimeFrame = timeFrame;
                incrementScene();

                if (idx == 0) {
                    cutChoice = CHOICE_SHORT;
                    if (this.ending) {
                        customer.x = 181;
                        customer.y = 101;
                        customer.loadGraphic(ImgKid6, true, true, 293, 399, true);
                    } else {
                        customer.x = 44;
                        customer.y = 14;
                        customer.loadGraphic(ImgCustomer1, true, true, 425, 470, true);
                    }
                } else if (idx == 1) {
                    cutChoice = CHOICE_MED;
                    if (this.ending) {
                        customer.x = 181;
                        customer.y = 20;
                        customer.loadGraphic(ImgKid5, true, true, 293, 456, true);
                    } else {
                        customer.x = 124;
                        customer.y = 9;
                        customer.loadGraphic(ImgCustomer2, true, true, 344, 468, true);
                    }
                } else if (idx == 2) {
                    cutChoice = CHOICE_LONG;
                    if (this.ending) {
                        customer.x = 181;
                        customer.y = 100;
                        customer.loadGraphic(ImgKid4, true, true, 293, 376, true);
                    } else {
                        customer.x = 110;
                        customer.y = 8;
                        customer.loadGraphic(ImgCustomer3, true, true, 356, 470, true);
                    }
                }
            }
        }
    }
}
