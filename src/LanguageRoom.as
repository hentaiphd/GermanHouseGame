package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/Room-4-Language.png")] private var ImgLanguageRoom:Class;
        [Embed(source="../assets/Bubble-02.png")] private var ImgKidBubble:Class;
        [Embed(source="../assets/LeaBlock-Regular.ttf", fontFamily="LeaBlock-Regular", embedAsCFF="false")] public var FontLea:String;
        private static const SEL_PROF:String = "prof_sel";
        public var wordList:Array;
        public var playerQuestions:Dictionary;
        public var playerAnswers:Dictionary;
        public var boardText:FlxText;
        public var word:String;

        public var kidBubble:FlxSprite;

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

            super.create();

            if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN){
                //eng stuff
            } else if(HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE){
                playerQuestions = new Dictionary();
                playerQuestions['Earful'] = new Array("An empty waste basket.", "A lot of angry talk.", "A good dancer.");
                playerQuestions['Cushy'] = new Array("Something easy or comfortable.", "A freshly baked pie.", "The color of a sunset.");
                playerQuestions['Wide-eyed'] = new Array("A juicy conversation.", "Being unsophisticated or innocent.", "Large flocks of geese.");
                playerQuestions['Weathervane'] = new Array("Used to measure wind direction.", "A mountable screen.", "A recruiter for an orchestra.");
                playerQuestions['Facetious'] = new Array("Soft, swishy or sweeping.", "Supportive or like a boulder.", "Joking about serious issues.");
                playerQuestions['Knee-slapper'] = new Array("A very funny joke.", "A fast-food restaurant.", "A very slippery slope.");
                playerQuestions['Canoodle'] = new Array("Hugging and kissing.", "Getting ready for bed.", "Wrapping a present.");

                playerAnswers = new Dictionary();
                playerAnswers['Earful'] = new String("A lot of angry talk.");
                playerAnswers['Cushy'] = new String("Something easy or comfortable.");
                playerAnswers['Wide-eyed'] = new String("Being unsophisticated or innocent.");
                playerAnswers['Weathervane'] = new String("Used to measure wind direction.");
                playerAnswers['Facetious'] = new String("Joking about serious issues.");
                playerAnswers['Knee-slapper'] = new String("A very funny joke.");
                playerAnswers['Canoodle'] = new Array("Hugging and kissing.");
            }

            wordList = getKeys(playerQuestions);
            boardText = new FlxText(230,100,500,"");
            boardText.setFormat("LeaBlock-Regular",18,0xff000000,"center");

            debugText = new FlxText(10,10,100,"");
            debugText.color = 0xff000000;
            debugText.size = 18;

            if(this.ending){
                this.setupBackground(ImgLanguageRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);

                add(debugText);
                add(boardText);

                kidBubble = new FlxSprite(7, 130);
                kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
                add(kidBubble);

                var randend:Number = Math.floor(Math.random()*wordList.length);
                word = wordList[randend].toString();
                boardText.text = word;
                conversation(new FlxPoint(kidBubble.x, kidBubble.y), new FlxPoint(600,600),"", this, SEL_PROF,
                         playerQuestions[word])();
            } else {
                this.setupBackground(ImgLanguageRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);

                add(debugText);
                add(boardText);

                kidBubble = new FlxSprite(7, 130);
                kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
                add(kidBubble);

                var rand:Number = Math.floor(Math.random()*wordList.length);
                word = wordList[rand].toString();
                boardText.text = word;
                conversation(new FlxPoint(kidBubble.x, kidBubble.y), new FlxPoint(600,600),"", this, SEL_PROF,
                         playerQuestions[word])();
            }
        }

        override public function update():void{
            super.update();
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new UpstairsRoom());
        }

        override public function didSelectTextOption(idx:Number, item:FlxText,
                                                     selector:SelectorTextBox):void
        {
            if (this.ending && selector._label == SEL_PROF) {
                if(item.text == playerAnswers[word]){
                    debugText.text = "win";
                } else {
                    debugText.text = "lose";
                }
                //add timer for this? bc someone will probs say something
                //depending on whether you win or lose
                //selector.destroy();
                //FlxG.switchState(new MenuState());
            } else if(!this.ending && selector._label == SEL_PROF){
                if(item.text == playerAnswers[word]){
                    debugText.text = "win";
                } else {
                    debugText.text = "lose";
                }
            }
        }
    }
}
