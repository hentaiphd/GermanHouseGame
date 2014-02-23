package
{
    import org.flixel.*;

    public class LanguageRoom extends MapRoom
    {
        [Embed(source="../assets/Room-4-Language.png")] private var ImgLanguageRoom:Class;
        [Embed(source="../assets/Bubble-02.png")] private var ImgKidBubble:Class;
        private static const SEL_PROF:String = "prof_sel";
        public var german_player_words:Array = new Array("Earful","Cushy","Wide-eyed","Weathervane","Facetious","Knee-slapper","Canoodle");
        public var german_player_answers:Array = new Array("");

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

            debugText = new FlxText(10,10,100,"");
            debugText.color = 0xff000000;
            debugText.size = 18;

            if(this.ending){
                this.setupBackground(ImgLanguageRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);

                add(debugText);

                kidBubble = new FlxSprite(7, 130);
                kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
                add(kidBubble);

                conversation(kidBubble.x, kidBubble.y,"", SEL_PROF,
                         new Array("Hi","Kannst du auch Deutsch?"), this)();
            } else {
                this.setupBackground(ImgLanguageRoom);
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);

                add(debugText);

                kidBubble = new FlxSprite(7, 130);
                kidBubble.loadGraphic(ImgKidBubble, true, true, 329, 144, true);
                add(kidBubble);

                conversation(kidBubble.x, kidBubble.y,"", SEL_PROF,
                         new Array("Hi","Kannst du auch Deutsch?"), this)();
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