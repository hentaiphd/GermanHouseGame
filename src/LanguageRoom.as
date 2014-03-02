package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/04-BG-01.png")] private var ImgBg:Class;
        [Embed(source="../assets/04-Kid-01.png")] private var ImgKidRight:Class;
        [Embed(source="../assets/04-Kid-02.png")] private var ImgKidLeft:Class;
        [Embed(source="../assets/04-Kid-04.png")] private var ImgKidRightEnd:Class;
        [Embed(source="../assets/04-Kid-03.png")] private var ImgKidLeftEnd:Class;
        [Embed(source="../assets/04-Parents-01.png")] private var ImgParents:Class;
        [Embed(source="../assets/04-Teacher-01.png")] private var ImgProfFront:Class;
        [Embed(source="../assets/04-Teacher-02.png")] private var ImgProfSide:Class;
        [Embed(source="../assets/Bubble-17.png")] private var ImgBubbleOne:Class;
        [Embed(source="../assets/Bubble-10.png")] private var ImgBubbleTwo:Class;
        [Embed(source="../assets/Bubble-02.png")] private var ImgBubbleThree:Class;
        [Embed(source="../assets/Bubble-13.png")] private var ImgBubbleFour:Class;
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
        private var profTextSeven:FlxText;
        private var profTextDefinition:FlxText;
        private var profTextWrong:FlxText;
        private var profTextRight:FlxText;
        private var profTextGuess:FlxText;
        private var kidTextOne:FlxText;
        private var kidTextTwo:FlxText;
        private var familyText:FlxText;

        private var profBubbleOne:FlxSprite;
        private var profBubbleTwo:FlxSprite;
        private var profFront:FlxSprite;
        private var profSide:FlxSprite;
        private var kidLeft:FlxSprite;
        private var kidRight:FlxSprite;
        private var kidBubble:FlxSprite;
        private var parents:FlxSprite;
        private var familyBubble:FlxSprite;

        private static const CHOICE_SHORT:int = 1;
        private static const CHOICE_MED:int = 2;
        private static const CHOICE_LONG:int = 3;
        private var cutChoice:Number;

        private static const SEL_PROF:String = "prof_sel";
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;

        override public function create():void
        {
            HouseMap.getInstance().LangRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            CONFIG::debugging {
                this.ending = true;
            }

            debugText = new FlxText(300,10,300,"");
            debugText.color = 0xff000000;
            debugText.size = 8;

            this.setupBackground(ImgBg);

            add(debugText);

            profBubbleOne = new FlxSprite(63, 30);
            profBubbleOne.loadGraphic(ImgBubbleOne, true, true, 254, 186, true);
            profBubbleOne.alpha = 0;
            add(profBubbleOne);

            profBubbleTwo = new FlxSprite(12, 10);
            profBubbleTwo.loadGraphic(ImgBubbleTwo, true, true, 319, 389, true);
            profBubbleTwo.alpha = 0;
            add(profBubbleTwo);

            kidBubble = new FlxSprite(83, 195);
            kidBubble.loadGraphic(ImgBubbleThree, true, true, 329, 144, true);
            kidBubble.alpha = 0;
            add(kidBubble);

            profFront = new FlxSprite(343, 49);
            profFront.loadGraphic(ImgProfFront, true, true, 271, 429, true);
            add(profFront);

            profSide = new FlxSprite(490, 76);
            profSide.loadGraphic(ImgProfSide, true, true, 138, 404, true);
            profSide.alpha = 0;
            add(profSide);

            familyBubble = new FlxSprite(12, 189);
            familyBubble.loadGraphic(ImgBubbleFour, true, true, 522, 178, true);
            familyBubble.alpha = 0;
            add(familyBubble);

            if(this.ending){
                parents = new FlxSprite(-2, 311);
                parents.loadGraphic(ImgParents, true, true, 332, 166);
                add(parents);

                kidRight = new FlxSprite(337, 366);
                kidRight.loadGraphic(ImgKidRightEnd, true, true, 116, 106, true);
                kidRight.alpha = 0;
                add(kidRight);

                kidLeft = new FlxSprite(337, 370);
                kidLeft.loadGraphic(ImgKidLeftEnd, true, true, 116, 106, true);
                add(kidLeft);
            } else {
                kidRight = new FlxSprite(262, 340);
                kidRight.loadGraphic(ImgKidRight, true, true, 130, 135, true);
                add(kidRight);

                kidLeft = new FlxSprite(262, 340);
                kidLeft.loadGraphic(ImgKidLeft, true, true, 132, 136, true);
                kidLeft.alpha = 0;
                add(kidLeft);
            }

            playerQuestions = new Dictionary();
            playerAnswers = new Dictionary();

            profTextOne = new FlxText(80, 46, 200, "");
            profTextOne.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextOne.alpha = 0;
            add(profTextOne);

            profTextTwo = new FlxText(80, 46, 200, "");
            profTextTwo.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextTwo.alpha = 0;
            add(profTextTwo);

            profTextSeven = new FlxText(80, 46, 200, "");
            profTextSeven.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextSeven.alpha = 0;
            add(profTextSeven);

            profTextThree = new FlxText(80, 46, 200, "");
            profTextThree.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextThree.alpha = 0;
            add(profTextThree);

            profTextFour = new FlxText(80, 73, 200, "");
            profTextFour.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextFour.alpha = 0;
            add(profTextFour);

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
            add(profTextFive);

            profTextSix = new FlxText(30, 55, 260, "");
            profTextSix.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            profTextSix.alpha = 0;
            add(profTextSix);

            kidTextOne = new FlxText(100, 210, 280, "");
            kidTextOne.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            kidTextOne.alpha = 0;
            add(kidTextOne);

            kidTextTwo = new FlxText(100, 210, 280, "");
            kidTextTwo.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            kidTextTwo.alpha = 0;
            add(kidTextTwo);

            familyText = new FlxText(35, 210, 490, "");
            familyText.setFormat("LeaBlock-Regular",18,0xff000000,"left");
            familyText.alpha = 0;
            add(familyText);

            if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN){
                if(!this.ending){
                    profTextOne.text = "Congratulations, you found the language program!";
                    profTextTwo.text = "You cannot leave the room until you have learned some German!";
                    profTextThree.text = "Let’s start!";
                    profTextFour.text = "Tell me what this word means.";
                    profTextFive.text = "You may leave and explore the other parts of Deutsches Haus now!";
                    profTextSix.text = "Now, try it again!";
                    profTextWrong.text = "That was wrong!";
                    profTextRight.text = "That was right!";
                } else if(this.ending){
                    profTextOne.text = "Congratulations, you found the language program!";
                    kidTextOne.text = "Mom! Dad! I found you!";
                    profTextTwo.text = "Your parents are trying to learn some German!";
                    profTextSeven.text = "But, I guess they need your help.";
                    kidTextTwo.text = "Really? I always thought you knew everything!";
                    profTextThree.text = "Let’s start!";
                    profTextFour.text = "Tell me what this word means.";
                    profTextFive.text = "You're a smart family after all!";
                    profTextSix.text = "Now, try it again!";
                    profTextWrong.text = "That was wrong!";
                    profTextRight.text = "That was right!";
                    familyText.text = "Thank you, teacher, we learned so much today! We'll definitely come back soon!";
                }


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
                if(!this.ending){
                    profTextOne.text = "Ich beglückwünsche dich, das Language Program gefunden zu haben!";
                    profTextTwo.text = "Du darfst den Raum erst wieder verlassen, wenn wir etwas englisch gelernt haben!";
                    profTextThree.text = "Los geht’s! ";
                    profTextFour.text = "Sag mir, was diese Worte heißen!";
                    profTextFive.text = "Prima, du darfst das Deutsche Haus jetzt weiter erkunden!";
                    profTextSix.text = "Versuch es gleich noch mal!";
                    profTextWrong.text = "Das war nicht richtig!";
                    profTextRight.text = "Das stimmt!";
                } else if(this.ending){
                    profTextOne.text = "Ich beglückwünsche dich, das Language Program gefunden zu haben!";
                    kidTextOne.text = "Mama und Papa, hier seid ihr!";
                    profTextTwo.text = "Deine Eltern versuchen gerade, etwas Englisch zu lernen.";
                    profTextSeven.text = "Aber sie könnten deine Hilfe gebrauchen!";
                    kidTextTwo.text = "Echt jetzt? Aber ihr wisst doch sonst immer alles!";
                    profTextThree.text = "Dann mal los!";
                    profTextFour.text = "Sag mir, was diese Worte heißen!";
                    profTextFive.text = "Ihr seid ja doch eine ganz schlaue Familie!";
                    profTextSix.text = "Versuch es gleich noch mal!";
                    profTextWrong.text = "Das war nicht richtig!";
                    profTextRight.text = "Das stimmt!";
                    familyText.text = "Danke, Herr Lehrer, wir haben heute viel gelernt! Nächstes Mal kommen wir auf jeden Fall wieder!";
                }

                playerQuestions['Earful'] = new Array("Ein leerer Papierkorb.", "viel wütendes Gerede.", "Ein guter Tänzer.");
                playerQuestions['Cushy'] = new Array("Etwas leichtes oder gemütliches.", "Eine frisch gebackene Torte.", "Die Farbe des Sonnenuntergangs.");
                playerQuestions['Wide-eyed'] = new Array("Verlockendes Gespräch.", "Ungekünstelt oder treuherzig.", "Scharen von Gänsen.");
                playerQuestions['Weathervane'] = new Array("Gegenstand um die Windrichtung zu messen.", "Hängender Bildschirm.", "Werber für ein Orchester.");
                playerQuestions['Facetious'] = new Array("Fließend oder weich.", "Fels in der Brandung.", "Über etwas Ernstes spaßend.");
                playerQuestions['Knee-slapper'] = new Array("Ein sehr lustiger Witze.", "Ein Schnell-Restaurant.", "Abwärtspfad.");
                playerQuestions['Canoodle'] = new Array("Umarmen und küssen.", "Immer bereit zu schlafen.", "Ein Geschenk einpacken.");

                playerAnswers['Earful'] = new String("viel wütendes Gerede.");
                playerAnswers['Cushy'] = new String("Etwas leichtes oder gemütliches.");
                playerAnswers['Wide-eyed'] = new String("Ungekünstelt oder treuherzig.");
                playerAnswers['Weathervane'] = new String("Gegenstand um die Windrichtung zu messen.");
                playerAnswers['Facetious'] = new String("Über etwas Ernstes spaßend.");
                playerAnswers['Knee-slapper'] = new String("Ein sehr lustiger Witze.");
                playerAnswers['Canoodle'] = new Array("Umarmen und küssen.");
            }

            wordList = getKeys(playerQuestions);
            boardText = new FlxText(40,50,500,"");
            boardText.setFormat("LeaBlock-Regular",24,0xff000000,"center");
            boardText.alpha = 0;
            add(boardText);

            var rand:Number = Math.floor(Math.random()*wordList.length);
            word = wordList[rand].toString();
            boardText.text = word;

            conversation(new FlxPoint(100, 100), new FlxPoint(450,230),"", this, SEL_PROF,
                         playerQuestions[word], true)();
        }

        override public function update():void{
            super.update();

            if(!this.ending){
                if (currentState == STATE_INTRO) {
                    if (current_scene == 0 && timeFrame == 1) {
                        current_scene += 1;
                    } else if (current_scene == 1 && startAgo(2)) {
                        current_scene += 1;
                    } else if (current_scene == 2 && startAgo(5)) {
                        current_scene += 1;
                    } else if (current_scene == 3 && startAgo(8)) {
                        current_scene += 1;
                    } else if (current_scene == 4 && startAgo(11)) {
                        current_scene += 1;
                    } else if (current_scene == 5 && startAgo(14)) {
                        switchState(STATE_CHOICE);
                    }
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 1 && lastStateAgo(1)) {
                        current_scene += 1;
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1 && lastStateAgo(2)) {
                        current_scene += 1;
                    } else if (current_scene == 2 && lastStateAgo(4)) {
                        current_scene += 1;
                    } else if (current_scene == 3 && lastStateAgo(6)) {
                        current_scene += 1;
                    } else if (current_scene == 4 && lastStateAgo(8)){
                        current_scene += 1;
                    } else if (current_scene == 5 && lastStateAgo(12)){
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
                                switchState(STATE_CHOICE);
                            }
                        }
                    }
                }
            } else if(this.ending){
                if (currentState == STATE_INTRO) {
                    if (current_scene == 0 && timeFrame == 1) {
                        current_scene += 1;
                    } else if (current_scene == 1 && startAgo(2)) {
                        current_scene += 1;
                    } else if (current_scene == 2 && startAgo(5)) {
                        current_scene += 1;
                    } else if (current_scene == 3 && startAgo(8)) {
                        current_scene += 1;
                    } else if (current_scene == 4 && startAgo(11)) {
                        current_scene += 1;
                    } else if (current_scene == 5 && startAgo(13)) {
                        current_scene += 1;
                    } else if (current_scene == 6 && startAgo(17)) {
                        current_scene += 1;
                    } else if (current_scene == 7 && startAgo(20)) {
                        current_scene += 1;
                    } else if (current_scene == 8 && startAgo(23)) {
                        switchState(STATE_CHOICE);
                    }
                } else if (currentState == STATE_CHOICE) {
                    if (current_scene == 1 && lastStateAgo(1)) {
                        current_scene += 1;
                    }
                } else if (currentState == STATE_RESULT) {
                    if (current_scene == 1 && lastStateAgo(1)) {
                        current_scene += 1;
                    } else if (current_scene == 2 && lastStateAgo(3)) {
                        current_scene += 1;
                    } else if (current_scene == 3 && lastStateAgo(5)) {
                        current_scene += 1;
                    } else if (current_scene == 4 && lastStateAgo(7)){
                        current_scene += 1;
                    } else if (current_scene == 5 && lastStateAgo(9)){
                        current_scene += 1;
                    } else if (current_scene == 6 && lastStateAgo(12)){
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
                        profBubbleOne.alpha -= ALPHA_DELTA;
                        kidBubble.alpha += ALPHA_DELTA;
                        kidTextOne.alpha += ALPHA_DELTA;
                    } else if(current_scene == 4){
                        kidBubble.alpha -= ALPHA_DELTA;
                        kidTextOne.alpha -= ALPHA_DELTA;
                        profBubbleOne.alpha += ALPHA_DELTA;
                        profTextTwo.alpha += ALPHA_DELTA;
                    } else if(current_scene == 5){
                        profTextTwo.alpha -= ALPHA_DELTA;
                        profTextSeven.alpha += ALPHA_DELTA;
                    } else if(current_scene == 6){
                        profTextSeven.alpha -= ALPHA_DELTA;
                        profBubbleOne.alpha -= ALPHA_DELTA;
                        kidBubble.alpha += ALPHA_DELTA;
                        kidTextTwo.alpha += ALPHA_DELTA;
                    } else if(current_scene == 7){
                        kidBubble.alpha -= ALPHA_DELTA;
                        kidTextTwo.alpha -= ALPHA_DELTA;
                        profBubbleOne.alpha += ALPHA_DELTA;
                        profTextThree.alpha += ALPHA_DELTA;
                    } else if(current_scene == 8){
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
                            kidLeft.alpha -= ALPHA_DELTA;
                            profFront.alpha -= ALPHA_DELTA;
                        }
                        kidRight.alpha += ALPHA_DELTA;
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
                        kidRight.alpha += ALPHA_DELTA;
                    } else if(current_scene >= 2){
                        if(profTextGuess.text == profTextRight.text){
                            if(current_scene == 2){
                                profTextRight.alpha += ALPHA_DELTA;
                            } else if(current_scene == 3){
                                profTextDefinition.alpha += ALPHA_DELTA
                            } else if(current_scene == 4){
                                profTextFive.alpha += ALPHA_DELTA;
                            } else if(current_scene == 5){
                                profTextRight.alpha -= ALPHA_DELTA;
                                profTextFive.alpha -= ALPHA_DELTA;
                                profTextDefinition.alpha -= ALPHA_DELTA;
                                profBubbleTwo.alpha -= ALPHA_DELTA;
                                familyBubble.alpha += ALPHA_DELTA;
                                familyText.alpha += ALPHA_DELTA;
                            }
                        } else if(profTextGuess.text == profTextWrong.text){
                            if(current_scene == 2){
                                profTextWrong.alpha += ALPHA_DELTA;
                            } else if(current_scene == 3){
                                profTextSix.alpha += ALPHA_DELTA;
                            } else if(current_scene == 4){
                                switchState(STATE_CHOICE);
                            }
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

                lastSelectionTimeFrame = timeFrame;
                switchState(STATE_RESULT);
            }
        }
    }
}
