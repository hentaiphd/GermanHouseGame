package
{
    import org.flixel.*;

    public class CultureRoom extends MapRoom
    {
        [Embed(source="../assets/0201-BG.png")] private var ImgBG:Class;
        [Embed(source="../assets/0202-Photographer.png")] private var ImgPhotographer:Class;
        [Embed(source="../assets/0203-Friseurin.png")] private var ImgFriseurin:Class;
        [Embed(source="../assets/0204-Kid.png")] private var ImgKid1:Class;
        [Embed(source="../assets/0204-Kid-1.png")] private var ImgKid2:Class;
        [Embed(source="../assets/Bubble-04.png")] private var ImgKidBubble1:Class;
        [Embed(source="../assets/Bubble-05.png")] private var ImgFriseurBubble1:Class;
        [Embed(source="../assets/Bubble-06.png")] private var ImgPhotographerBubble1:Class;

        private var photographer:FlxSprite;
        private var friseurin:FlxSprite;
        private var kid:FlxSprite;
        private var kid2:FlxSprite;
        private var kidBubble1:FlxSprite;
        private var kidBubble1Text:FlxText;
        private var friseurBubble1:FlxSprite;
        private var friseurBubble1Text:FlxText;
        private var photographerBubble1:FlxSprite;
        private var photographerBubble1Text:FlxText;

        private static const STATE_INTRO:int = 1;
        private static const STATE_CHOICE:int = 2;
        private static const STATE_RESULT:int = 3;
        private var currentState:int = STATE_INTRO;
        public var current_scene:Number = 0;

        private const ALPHA_DELTA:Number = .04;

        override public function create():void
        {
            HouseMap.getInstance().CultureRoom = true;
            HouseMap.getInstance().endingCounter++;

            super.create();

            this.setupBackground(ImgBG);

            var kidText1:String, friseurText1:String, photographerText1:String;
            if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                kidText1 = "What are you doing?";
                friseurText1 = "I'm cutting her hair!";
                photographerText1 = "I'm a photographer and there will be an exhibition afterwards.";
            } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                kidText1 = "Was machst du denn da?";
                friseurText1 = "Ich verpass ihr einen hippen Haarschnitt!";
                photographerText1 = "Ich mache Fotos, für eine Ausstellung, die es darüber geben wird!";
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

            if(this.ending){
                var t:FlxText = new FlxText(10,10,100,"end");
                add(t);
            } else {
                this.addClickZone(new FlxPoint(100, 100), new FlxPoint(40, 40),
                    null, doorWasClicked);
            }
            player = new Player(20,150);
            add(player);
        }

        override public function update():void{
            super.update();

            if (current_scene == 0 && timeFrame == 1) {
                current_scene += 1;
            } else if (current_scene == 1 && timeFrame == 3*TimedState.fpSec) {
                current_scene += 1;
            } else if (current_scene == 2 && timeFrame == 6*TimedState.fpSec) {
                current_scene += 1;
            } else if (current_scene == 3 && timeFrame == 9*TimedState.fpSec) {
                current_scene += 1;
            }

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
        }

        private function doorWasClicked(a:FlxSprite, b:FlxSprite):void
        {
            FlxG.switchState(new LobbyRoom());
        }
    }
}
