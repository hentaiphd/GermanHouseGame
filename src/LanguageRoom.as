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
        public var germanPlayerQuestions:Dictionary;
        public var boardText:FlxText;

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

            //if player is a german speaker
            germanPlayerQuestions = new Dictionary();
            germanPlayerQuestions['Earful'] = new Array("An empty waste basket.", "A lot of angry talk.", "A good dancer.");
            germanPlayerQuestions['Cushy'] = new Array("Something easy or comfortable.", "A freshly baked pie.", "The color of a sunset.");
            germanPlayerQuestions['Wide-eyed'] = new Array("A juicy conversation.", "Being unsophisticated or innocent.", "Large flocks of geese.");
            germanPlayerQuestions['Weathervane'] = new Array("Used to measure wind direction.", "A mountable screen.", "A recruiter for an orchestra.");
            germanPlayerQuestions['Facetious'] = new Array("Soft, swishy or sweeping.", "Supportive or like a boulder.", "Joking about serious issues.");
            germanPlayerQuestions['Knee-slapper'] = new Array("A very funny joke.", "A fast-food restaurant.", "A very slippery slope.");
            germanPlayerQuestions['Canoodle'] = new Array("Hugging and kissing.", "Getting ready for bed.", "Wrapping a present.");

            wordList = getKeys(germanPlayerQuestions);
            boardText = new FlxText(230,100,300,"");
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
                var wordend:String = wordList[randend].toString();
                boardText.text = wordend;
                conversation(new FlxPoint(kidBubble.x, kidBubble.y), new FlxPoint(300,300),"", SEL_PROF,
                         germanPlayerQuestions[wordend], this)();
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
                var word:String = wordList[rand].toString();
                boardText.text = word;
                conversation(new FlxPoint(kidBubble.x, kidBubble.y), new FlxPoint(300,100),"", SEL_PROF,
                         germanPlayerQuestions[word], this)();
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
                debugText.text = "parent end select";

                selector.destroy();
                FlxG.switchState(new MenuState());

                if (idx == 0) {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_EN;
                } else {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;
                }
            } else if(!this.ending && selector._label == SEL_PROF){
                debugText.text = "not parent end select";

                selector.destroy();
                FlxG.switchState(new UpstairsRoom());

                if (idx == 0) {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_EN;
                } else {
                    HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;
                }
            }
        }
    }
}
