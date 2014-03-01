package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/0201-BG.png")] private var ImgBG:Class;
        [Embed(source="../assets/02-BG-1.png")] private var ImgBGOffer:Class;
        [Embed(source="../assets/02-BG-2.png")] private var ImgBGResult:Class;
        [Embed(source="../assets/0202-Photographer.png")] private var ImgPhotographer:Class;
        [Embed(source="../assets/0203-Friseurin.png")] private var ImgFriseurin:Class;
        [Embed(source="../assets/0204-Kid.png")] private var ImgKid1:Class;
        [Embed(source="../assets/0204-Kid-1.png")] private var ImgKid2:Class;
        [Embed(source="../assets/02-Kid-2.png")] private var ImgKid3:Class;
        [Embed(source="../assets/Bubble-04.png")] private var ImgKidBubble1:Class;
        [Embed(source="../assets/Bubble-05.png")] private var ImgFriseurBubble1:Class;
        [Embed(source="../assets/Bubble-06.png")] private var ImgPhotographerBubble1:Class;
        [Embed(source="../assets/Bubble-07.png")] private var ImgOfferBubble1:Class;
        [Embed(source="../assets/Bubble-08.png")] private var ImgOfferBubble2:Class;
        [Embed(source="../assets/02-Customer-1.png")] private var ImgCustomer1:Class;
        [Embed(source="../assets/02-Customer-2.png")] private var ImgCustomer2:Class;
        [Embed(source="../assets/02-Customer-3.png")] private var ImgCustomer3:Class;
        [Embed(source="../assets/02-Scissors-01.png")] private var ImgScissors1:Class;
        [Embed(source="../assets/02-Scissors-02.png")] private var ImgScissors2:Class;
        [Embed(source="../assets/02-Scissors-03.png")] private var ImgScissors3:Class;

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
        private var endText2:String;
        private var cutOption1:FlxSprite, cutOption2:FlxSprite, cutOption3:FlxSprite;

        private static const CHOICE_SHORT:int = 1;
        private static const CHOICE_MED:int = 2;
        private static const CHOICE_LONG:int = 3;
        private var cutChoice:Number;

        private static const STATE_INTRO:int = 1;
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;
        private var currentState:int = STATE_INTRO;
        public var current_scene:Number = 0;

        private const ALPHA_DELTA:Number = .04;

        private static const SEL_OFFER:String = "offer_sel";

        override public function create():void
        {
            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgBG);

            var kidText1:String, friseurText1:String, photographerText1:String,
                offerText:String, resultText:String, endText1:String;
            var offerChoices:Array = new Array();
            if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                kidText1 = "What are you doing?";
                friseurText1 = "I'm cutting her hair!";
                photographerText1 = "I'm a photographer and there will be an exhibition afterwards.";
                offerText = "You wanna try for yourself, sweetie?";
                offerChoices = new Array("Cut a little", "Cut something", "Cut a lot");
                resultText = "That's not bad, kid!";
                endText1 = "But your parents are not here, at the cultural program.";
                endText2 = "You will have to find them in another part of Deutsches Haus";
            } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                kidText1 = "Was machst du denn da?";
                friseurText1 = "Ich verpass ihr einen hippen Haarschnitt!";
                photographerText1 = "Ich mache Fotos, für eine Ausstellung, die es darüber geben wird!";
                offerText = "Willstes mal selber probieren?";
                offerChoices = new Array("Wenig abschneiden", "Etwas abschneiden", "Viel abschneiden");
                resultText = "Wow! Gar nicht schlecht ist das!";
                endText1 = "Aber deine Eltern sind leider nicht hier, im Kulturprogramm!";
                endText2 = "Die müssen irgendwo anders im Deutschen Haus sein.";
            }

            photographer = new FlxSprite(34, 96);
            photographer.loadGraphic(ImgPhotographer, true, true, 235, 220, true);
            add(photographer);

            friseurin = new FlxSprite(325, 26);
            friseurin.loadGraphic(ImgFriseurin, true, true, 288, 291, true);
            add(friseurin);

            kid = new FlxSprite(248, 342);
            kid.loadGraphic(ImgKid1, true, true, 130, 133, true);
            add(kid);

            kid2 = new FlxSprite(248, 342);
            kid2.loadGraphic(ImgKid2, true, true, 130, 133, true);
            kid2.alpha = 0;
            add(kid2);

            kidBubble1 = new FlxSprite(374, 332);
            kidBubble1.loadGraphic(ImgKidBubble1, true, true, 254, 137, true);
            kidBubble1.alpha = 0;
            add(kidBubble1);
            kidBubble1Text = new TextBox(new FlxPoint(kidBubble1.x+40, kidBubble1.y+10),
                                         new FlxPoint(kidBubble1.width-40, kidBubble1.height),
                                         kidText1);
            kidBubble1Text.alpha = 0;
            add(kidBubble1Text);

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
            photographerBubble1Text = new TextBox(new FlxPoint(photographerBubble1.x+10, photographerBubble1.y+40),
                                             new FlxPoint(photographerBubble1.width-20, photographerBubble1.height),
                                             photographerText1);
            photographerBubble1Text.alpha = 0;
            add(photographerBubble1Text);

            offerBackground = new FlxSprite(0, 0);
            offerBackground.loadGraphic(ImgBGOffer, true, true, 640, 480, true);
            offerBackground.alpha = 0;
            add(offerBackground);

            offerBubble = new FlxSprite(11, 10);
            offerBubble.loadGraphic(ImgOfferBubble1, true, true, 361, 457, true);
            offerBubble.alpha = 0;
            add(offerBubble);

            resultBackground = new FlxSprite(0, 0);
            resultBackground.loadGraphic(ImgBGResult, true, true, 640, 480, true);
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

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            }

            cutOption1 = new FlxSprite(0, 0);
            cutOption1.loadGraphic(ImgScissors1, true, true, 70, 76, true);

            cutOption2 = new FlxSprite(0, 0);
            cutOption2.loadGraphic(ImgScissors2, true, true, 70, 80, true);

            cutOption3 = new FlxSprite(0, 0);
            cutOption3.loadGraphic(ImgScissors3, true, true, 81, 108, true);

            var choiceImages:Array = new Array(cutOption1, cutOption2, cutOption3);

            conversation(new FlxPoint(offerBubble.x+30, offerBubble.y+30),
                         new FlxPoint(offerBubble.width-80, offerBubble.height),
                         offerText, this, SEL_OFFER, offerChoices, true, 120, choiceImages)();
        }

        override public function update():void{
            super.update();

            if (currentState == STATE_INTRO) {
                if (current_scene == 0 && timeFrame == 1) {
                    current_scene += 1;
                } else if (current_scene == 1 && timeFrame == 2*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 2 && timeFrame == 4*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == 6*TimedState.fpSec) {
                    current_scene = 1;
                    currentState = STATE_CHOICE;
                    lastStateChangeTimeFrame = timeFrame;
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+1*TimedState.fpSec) {
                    current_scene += 1;
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+3*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 2 && timeFrame == lastStateChangeTimeFrame+5*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == lastStateChangeTimeFrame+7*TimedState.fpSec) {
                    current_scene += 1;
                    resultText2.text = endText2;
                } else if (current_scene == 4 && timeFrame == lastStateChangeTimeFrame+10*TimedState.fpSec) {
                    current_scene += 1;
                    FlxG.switchState(new LobbyRoom());
                }
            }

            if (currentState == STATE_INTRO) {
                if (current_scene == 1) {
                    kidBubble1.alpha += ALPHA_DELTA;
                    kidBubble1Text.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {
                    kidBubble1.alpha -= ALPHA_DELTA;
                    kidBubble1Text.alpha -= ALPHA_DELTA;
                    friseurBubble1.alpha += ALPHA_DELTA;
                    friseurBubble1Text.alpha += ALPHA_DELTA;
                } else if (current_scene == 3) {
                    kid.alpha -= ALPHA_DELTA;
                    kid2.alpha += ALPHA_DELTA;
                    friseurBubble1.alpha -= ALPHA_DELTA;
                    friseurBubble1Text.alpha -= ALPHA_DELTA;
                    photographerBubble1.alpha += ALPHA_DELTA;
                    photographerBubble1Text.alpha += ALPHA_DELTA;
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1) {
                    bgImage.alpha -= ALPHA_DELTA;
                    kid2.alpha -= ALPHA_DELTA;
                    friseurin.alpha -= ALPHA_DELTA;
                    photographer.alpha -= ALPHA_DELTA;
                    photographerBubble1.alpha -= ALPHA_DELTA;
                    photographerBubble1Text.alpha -= ALPHA_DELTA;
                    offerBackground.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {
                    offerBubble.alpha += ALPHA_DELTA;
                    this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1) {
                    offerBubble.alpha -= ALPHA_DELTA;
                    offerBackground.alpha -= ALPHA_DELTA;
                    this.activeSelectorBox.incrementAlpha(-ALPHA_DELTA);
                    resultBackground.alpha += ALPHA_DELTA;
                    kid3.alpha += ALPHA_DELTA;
                    customer.alpha += ALPHA_DELTA;
                } else if (current_scene == 2) {
                    resultBubble1.alpha += ALPHA_DELTA;
                    resultText1.alpha += ALPHA_DELTA;
                } else if (current_scene == 3) {
                    resultBubble1.alpha -= ALPHA_DELTA;
                    resultText1.alpha -= ALPHA_DELTA;
                    resultBubble2.alpha += ALPHA_DELTA;
                    resultText2.alpha += ALPHA_DELTA;
                }
            }
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_CHOICE && current_scene == 2
                && selector._label == SEL_OFFER)
            {
                current_scene = 1;
                currentState = STATE_RESULT;
                lastSelectionTimeFrame = timeFrame;
                lastStateChangeTimeFrame = timeFrame;

                if (idx == 0) {
                    cutChoice = CHOICE_SHORT;
                    customer.x = 44;
                    customer.y = 14;
                    customer.loadGraphic(ImgCustomer1, true, true, 425, 470, true);
                } else if (idx == 1) {
                    cutChoice = CHOICE_MED;
                    customer.x = 124;
                    customer.y = 9;
                    customer.loadGraphic(ImgCustomer2, true, true, 344, 468, true);
                } else if (idx == 2) {
                    cutChoice = CHOICE_LONG;
                    customer.x = 110;
                    customer.y = 8;
                    customer.loadGraphic(ImgCustomer3, true, true, 356, 470, true);
                }
            }
        }
    }
}
