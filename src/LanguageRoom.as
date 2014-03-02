package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/04-BG-01.png")] private var ImgBg:Class;
        [Embed(source="../assets/04-Kid-01.png")] private var ImgKidRight:Class;
        [Embed(source="../assets/04-Kid-02.png")] private var ImgKidLeft:Class;
        [Embed(source="../assets/04-Teacher-01.png")] private var ImgProfFront:Class;
        [Embed(source="../assets/04-Teacher-02.png")] private var ImgProfSide:Class;
        [Embed(source="../assets/Bubble-09.png")] private var ImgBubbleOne:Class;
        [Embed(source="../assets/Bubble-10.png")] private var ImgBubbleTwo:Class;
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;
        private var wordList:Array;
        private var playerQuestions:Dictionary;
        private var playerAnswers:Dictionary;
        private var boardText:FlxText;
        private var word:String;
        private var retry:Boolean = false;

        private var profTextOne:FlxText;
        private var profTextTwo:FlxText;
        private var profTextThree:FlxText;
        private var profTextFour:FlxText;
        private var profTextFive:FlxText;
        private var profTextSix:FlxText;
        private var profTextDefinition:FlxText;
        private var profTextWrong:FlxText;
        private var profTextRight:FlxText;
        private var profTextGuess:FlxText;

        private var profBubbleOne:FlxSprite;
        private var profBubbleTwo:FlxSprite;
        private var profFront:FlxSprite;
        private var profSide:FlxSprite;
        private var kidLeft:FlxSprite;
        private var kidRight:FlxSprite;

        private static const CHOICE_SHORT:int = 1;
        private static const CHOICE_MED:int = 2;
        private static const CHOICE_LONG:int = 3;
        private var cutChoice:Number;

        private static const SEL_PROF:String = "prof_sel";
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;
        public var current_scene:Number = 0;

        private const ALPHA_DELTA:Number = .04;

        //german player version
        //Earful - (1) An empty waste basket. (2) A lot of angry talk. (3) A good dancer.
        //Cushy - (1) Something easy or comfortable. (2) A freshly baked pie. (3) The color of a sunset.
        //Wide-eyed - (1) A juicy conversation. (2) Being unsophisticated or innocent. (3) Large flocks of geese.
        //Weathervane - (1) Used to measure wind direction. (2) A mountable screen. (3) A recruiter for an orchestra.
        //Facetious - (1) Soft, swishy or sweeping. (2) Supportive or like a boulder. (3) Joking about serious issues.
        //Knee-slapper (1) A very funny joke. (2) A fast-food restaurant. (3) A very slippery slope.
        //Canoodle (1) Hugging and kissing. (2) Getting ready for bed. (3) Wrapping a present.

        override public function create():void
        {
            HouseMap.getInstance().LangRoom = true;
            HouseMap.getInstance().endingCounter++;

            //HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;

            super.create();

            debugText = new FlxText(300,10,300,"");
            debugText.color = 0xff000000;
            debugText.size = 8;

            this.setupBackground(ImgBg);

            if(this.ending){
                add(debugText);
            } else {
                add(debugText);
            }

            profFront = new FlxSprite(343, 49);
            profFront.loadGraphic(ImgProfFront, true, true, 271, 429, true);
            add(profFront);

            profSide = new FlxSprite(490, 76);
            profSide.loadGraphic(ImgProfSide, true, true, 138, 404, true);
            profSide.alpha = 0;
            add(profSide);

            profBubbleOne = new FlxSprite(63, 30);
            profBubbleOne.loadGraphic(ImgBubbleOne, true, true, 254, 137, true);
            profBubbleOne.alpha = 0;
            add(profBubbleOne);

            profBubbleTwo = new FlxSprite(12, 10);
            profBubbleTwo.loadGraphic(ImgBubbleTwo, true, true, 319, 389, true);
            profBubbleTwo.alpha = 0;
            add(profBubbleTwo);

            kidRight = new FlxSprite(262, 340);
            kidRight.loadGraphic(ImgKidRight, true, true, 130, 135, true);
            add(kidRight);

            kidLeft = new FlxSprite(262, 340);
            kidLeft.loadGraphic(ImgKidLeft, true, true, 132, 136, true);
            kidLeft.alpha = 0;
            add(kidLeft);

            playerQuestions = new Dictionary();
            playerAnswers = new Dictionary();

            profTextOne = new FlxText(80, 46, 250, "");
            profTextOne.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextOne.alpha = 0;
            add(profTextOne);

            profTextTwo = new FlxText(80, 46, 210, "");
            profTextTwo.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextTwo.alpha = 0;
            add(profTextTwo);

            profTextThree = new FlxText(80, 46, 250, "");
            profTextThree.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextThree.alpha = 0;
            add(profTextThree);

            profTextFour = new FlxText(80, 73, 210, "");
            profTextFour.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextFour.alpha = 0;
            add(profTextFour)

            profTextWrong = new FlxText(30, 30, 270, "");
            profTextWrong.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextWrong.alpha = 0;
            add(profTextWrong);

            profTextRight = new FlxText(30, 30, 270, "");
            profTextRight.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextRight.alpha = 0;
            add(profTextRight);

            profTextGuess = new FlxText(30, 30, 315, "");
            profTextGuess.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextGuess.alpha = 0;
            add(profTextGuess);

            profTextDefinition = new FlxText(30, 85, 250, "");
            profTextDefinition.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextDefinition.alpha = 0;
            add(profTextDefinition);

            profTextFive = new FlxText(30, 190, 250, "");
            profTextFive.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextFive.alpha = 0;
            add(profTextFive)

            profTextSix = new FlxText(30, 55, 270, "");
            profTextSix.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextSix.alpha = 0;
            add(profTextSix)

            if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN){
                profTextOne.text = "Congratulations, you found the language program!";
                profTextTwo.text = "You cannot leave the room until you have learned some German!";
                profTextThree.text = "Let’s start!";
                profTextFour.text = "Tell me what this word means.";
                profTextFive.text = "You may leave and explore the other parts of Deutsches Haus now!";
                profTextSix.text = "Now, try it again!";
                profTextWrong.text = "That was wrong!";
                profTextRight.text = "That was right!";

                playerQuestions['Wanderlust'] = new Array("One skilled in various techniques of queuing.", "Desire to wander.", "Fool’s license.");
                playerQuestions['Narrenfreiheit'] = new Array("Desire to wander.", "Supper.", "Fool’s license.");
                playerQuestions['Abendbrot'] = new Array("Fool’s license.", "Supper.", "Inner conflict.");
                playerQuestions['Zerrissenheit'] = new Array("Supper.", "Inner conflict.", "Low mountain range.");
                playerQuestions['Mittelgebirge'] = new Array("Inner conflict.", "Low mountain range.", "Roofed wicker beach chair.");
                playerQuestions['Strandkorb'] = new Array("Low mountain range.", "Roofed wicker beach chair.", "The urge to confess.");

                playerAnswers['Wanderlust'] = new String("Desire to wander.");
                playerAnswers['Narrenfreiheit'] = new String("Fool’s license.");
                playerAnswers['Abendbrot'] = new String("Supper.");
                playerAnswers['Zerrissenheit'] = new String("Inner conflict.");
                playerAnswers['Mittelgebirge'] = new String("Low mountain range.");
                playerAnswers['Strandkorb'] = new String("Roofed wicker beach chair.");

            } else if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE){
                profTextOne.text = "Ich beglückwünsche dich, das Language Program gefunden zu haben!";
                profTextTwo.text = "Du darfst den Raum erst wieder verlassen, wenn wir etwas englisch gelernt haben!";
                profTextThree.text = "Los geht’s! ";
                profTextFour.text = "Sag mir, was diese Worte heißen!";
                profTextFive.text = "Prima, du darfst das Deutsche Haus jetzt weiter erkunden!";
                profTextSix.text = "Versuch es gleich noch mal!";
                profTextWrong.text = "Das war nicht richtig!";
                profTextRight.text = "Das stimmt!";

                playerQuestions['Earful'] = new Array("An empty waste basket.", "A lot of angry talk.", "A good dancer.");
                playerQuestions['Cushy'] = new Array("Something easy or comfortable.", "A freshly baked pie.", "The color of a sunset.");
                playerQuestions['Wide-eyed'] = new Array("A juicy conversation.", "Being unsophisticated or innocent.", "Large flocks of geese.");
                playerQuestions['Weathervane'] = new Array("A thing used to measure wind direction.", "A mountable screen.", "A recruiter for an orchestra.");
                playerQuestions['Facetious'] = new Array("Soft, swishy or sweeping.", "Supportive or like a boulder.", "Joking about serious issues.");
                playerQuestions['Knee-slapper'] = new Array("A very funny joke.", "A fast-food restaurant.", "A very slippery slope.");
                playerQuestions['Canoodle'] = new Array("Hugging and kissing.", "Getting ready for bed.", "Wrapping a present.");

                playerAnswers['Earful'] = new String("A lot of angry talk.");
                playerAnswers['Cushy'] = new String("Something easy or comfortable.");
                playerAnswers['Wide-eyed'] = new String("Being unsophisticated or innocent.");
                playerAnswers['Weathervane'] = new String("A thing used to measure wind direction.");
                playerAnswers['Facetious'] = new String("Joking about serious issues.");
                playerAnswers['Knee-slapper'] = new String("A very funny joke.");
                playerAnswers['Canoodle'] = new Array("Hugging and kissing.");
            }

            wordList = getKeys(playerQuestions);
            boardText = new FlxText(40,50,500,"");
            boardText.setFormat("LeaBlock-Regular",24,0xff000000,"center");
            boardText.alpha = 0;
            add(boardText);

            var rand:Number = Math.floor(Math.random()*wordList.length);
            word = wordList[rand].toString();
            boardText.text = word;

            conversation(new FlxPoint(40, 100), new FlxPoint(450,230),"", this, SEL_PROF,
                         playerQuestions[word], true)();
        }

        override public function update():void{
            super.update();
            debugText.text = "current scene: " + current_scene.toString() + " and current state: " + currentState.toString() + "retry: " + retry.toString();

            if (currentState == STATE_INTRO) {
                if (current_scene == 0 && timeFrame == 1) {
                    current_scene += 1;
                } else if (current_scene == 1 && timeFrame == 2*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 2 && timeFrame == 5*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == 8*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 4 && timeFrame == 11*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 5 && timeFrame == 14*TimedState.fpSec) {
                    current_scene = 1;
                    switchState(STATE_CHOICE);
                }
            } else if (currentState == STATE_CHOICE) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+1*TimedState.fpSec) {
                    current_scene += 1;
                }
            } else if (currentState == STATE_RESULT) {
                if (current_scene == 1 && timeFrame == lastStateChangeTimeFrame+2*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 2 && timeFrame == lastStateChangeTimeFrame+4*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 3 && timeFrame == lastStateChangeTimeFrame+6*TimedState.fpSec) {
                    current_scene += 1;
                } else if (current_scene == 4 && timeFrame == lastStateChangeTimeFrame+8*TimedState.fpSec){
                    current_scene += 1;
                } else if (current_scene == 5 && timeFrame == lastStateChangeTimeFrame+12*TimedState.fpSec){
                    if(!retry){
                        FlxG.switchState(new UpstairsRoom());
                    }
                }
            }

            if(currentState == STATE_INTRO){
                if(current_scene == 1){
                    profBubbleOne.alpha += ALPHA_DELTA;
                } else if(current_scene == 2){
                    profTextOne.alpha += ALPHA_DELTA;
                } else if(current_scene == 3){
                    profTextOne.alpha -= ALPHA_DELTA;
                    profTextTwo.alpha += ALPHA_DELTA;
                } else if(current_scene == 4){
                    profTextTwo.alpha -= ALPHA_DELTA;
                    profTextThree.alpha += ALPHA_DELTA;
                } else if(current_scene == 5){
                    profTextFour.alpha += ALPHA_DELTA;
                }
            } else if(currentState == STATE_CHOICE){
                if(current_scene == 1){
                    if(retry){
                        profFront.alpha -= ALPHA_DELTA;
                        profBubbleTwo.alpha -= ALPHA_DELTA;
                        profTextWrong.alpha -= ALPHA_DELTA;
                        profTextSix.alpha -= ALPHA_DELTA;
                    } else {
                        profTextThree.alpha -= ALPHA_DELTA;
                        profTextFour.alpha -= ALPHA_DELTA;
                        profBubbleOne.alpha -= ALPHA_DELTA;
                        kidRight.alpha -= ALPHA_DELTA;
                        profFront.alpha -= ALPHA_DELTA;
                    }
                    kidLeft.alpha += ALPHA_DELTA;
                    profSide.alpha += ALPHA_DELTA;
                } else if(current_scene == 2){
                    boardText.alpha += ALPHA_DELTA;
                    this.activeSelectorBox.incrementAlpha(ALPHA_DELTA);
                }
            } else if(currentState == STATE_RESULT){
                if(current_scene == 1){
                    this.activeSelectorBox.incrementAlpha(-ALPHA_DELTA);
                    boardText.alpha -= ALPHA_DELTA;
                    profSide.alpha -= ALPHA_DELTA;
                    profFront.alpha += ALPHA_DELTA;
                    profBubbleTwo.alpha += ALPHA_DELTA;
                    kidLeft.alpha += ALPHA_DELTA;
                } else if(current_scene >= 2){
                    if(profTextGuess.text == profTextRight.text){
                        if(current_scene == 2){
                            profTextRight.alpha += ALPHA_DELTA;
                        } else if(current_scene == 3){
                            profTextDefinition.alpha += ALPHA_DELTA
                        } else if(current_scene == 4){
                            profTextFive.alpha += ALPHA_DELTA;
                        }
                    } else if(profTextGuess.text == profTextWrong.text){
                        if(current_scene == 2){
                            profTextWrong.alpha += ALPHA_DELTA;
                        } else if(current_scene == 3){
                            profTextSix.alpha += ALPHA_DELTA;
                        } else if(current_scene == 4){
                            current_scene = 1;
                            switchState(STATE_CHOICE);
                        }
                    }
                }
            }
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new UpstairsRoom());
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (currentState == STATE_CHOICE && current_scene == 2
                && selector._label == SEL_PROF){
                //if (this.ending) {
                //} else if(!this.ending){
                //}

                //allow player to guess until they get the right one

                if(item.text == playerAnswers[word]){
                    profTextGuess.text = profTextRight.text;

                    if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE){
                        profTextDefinition.text = boardText.text + " bedeutet " + "\"" + playerAnswers[word] + "\"";
                    } else if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                        profTextDefinition.text = boardText.text + " means " + "\"" + playerAnswers[word] + "\"";
                    }
                    retry = false;
                } else {
                    profTextGuess.text = profTextWrong.text;
                    retry = true;
                }

                current_scene = 1;
                lastSelectionTimeFrame = timeFrame;
                switchState(STATE_RESULT);
            }
        }
    }
}
