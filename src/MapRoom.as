package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class MapRoom extends TimedState
    {
        public var mouse:AnimatedCursor;
        public var bgImage:FlxSprite;
        private var zones:Dictionary;

        public var lastSelectionTimeFrame:Number = -1;
        public var lastCollideTimeFrame:Number = -1;
        public var lastClickTimeFrame:Number = -1;
        public var lastStateChangeTimeFrame:Number = -1;
        public var activeSelectorBox:SelectorTextBox = null;
        public var activeTextBox:TextBox = null;
        public var player:Player;
        public var ending:Boolean = false;
        public var debugText:FlxText;

        public static const STATE_INTRO:int = 1;
        public var currentState:int = STATE_INTRO;
        public var current_scene:Number = 0;

        public const ALPHA_DELTA:Number = .04;

        public function MapRoom()
        {
            this.zones = new Dictionary();
        }

        override public function create():void
        {
            super.create();
            endingChecker();
        }

        override public function update():void
        {
            super.update();
            if (FlxG.mouse.pressed()) {
                lastClickTimeFrame = timeFrame;
            }

            if(this.activeSelectorBox != null){
                this.activeSelectorBox.update();
            }

            var clickzone:FlxRect = new FlxRect(0, 0, 0, 0);
            for (var k:Object in this.zones) {
                var contactFn:Function = this.zones[k];
                var _clickZone:DHButton = k as DHButton;
                this.doContact(_clickZone, contactFn);
                //if(contactFn != null){
                    clickzone.x = _clickZone.x;
                    clickzone.y = _clickZone.y;
                    clickzone.width = _clickZone.width;
                    clickzone.height = _clickZone.height;

                    if(mouse.rect.overlaps(clickzone)){
                        mouse.hovering = true
                        debugText.text = mouse.hovering.toString();
                    }else{
                        debugText.text = mouse.hovering.toString();
                        mouse.hovering = false;
                    }
                /*}else{
                    mouse.hovering = false;
                }*/
            }

            CONFIG::debugging {
                if (FlxG.keys.justReleased("SPACE")) {
                    var _text:DHFadeText = new DHFadeText(new FlxPoint(100, 100), new FlxPoint(300, 100), "");
                    if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_DE) {
                        HouseMap.getInstance().currentLanguage = HouseMap.LANG_EN;
                        _text.text = "ENGLISH";
                    } else if (HouseMap.getInstance().currentLanguage == HouseMap.LANG_EN) {
                        HouseMap.getInstance().currentLanguage = HouseMap.LANG_DE;
                        _text.text = "DEUTSCH";
                    }
                    this.switchLanguage();
                    FlxG.state.add(_text);
                }
            }
        }

        public function postCreate():void{
            mouse = new AnimatedCursor();
            add(mouse);
            FlxG.mouse.hide();

            debugText = new FlxText(10,10,500,"");
            debugText.size = 20;
            debugText.color = 0xff000000;
            add(debugText);
            debugText.text = mouse.hovering.toString();
        }

        public function switchLanguage():void
        {}

        public function switchState(state:int):void
        {
            this.currentState = state;
            lastStateChangeTimeFrame = timeFrame;
            current_scene = 1;
        }

        public function framesSinceLastState():Number
        {
            return timeFrame - lastStateChangeTimeFrame;
        }

        public function lastStateAgo(sec:Number):Boolean
        {
            /* return true if the last state happened exactly 'sec' seconds ago */
            if (sec*TimedState.fpSec + lastStateChangeTimeFrame == timeFrame) {
                return true;
            }
            return false;
        }

        public function startAgo(sec:Number):Boolean
        {
            /* return true if the flxstate started exactly 'sec' seconds ago */
            if (sec*TimedState.fpSec == timeFrame) {
                return true;
            }
            return false;
        }

        private function doContact(_clickZone:DHButton, contactFn:Function):void
        {
            function _callback(a:FlxSprite, b:FlxSprite):void
            {
                if (_clickZone.wasClicked) {
                    player.collideFn();
                    if (contactFn != null) {
                        contactFn(a, b);
                    }
                }
            }
            FlxG.collide(player,_clickZone,_callback);
        }

        public function setupBackground(image:Class):void
        {
            this.bgImage = new FlxSprite(0, 0);
            this.bgImage.loadGraphic(image, true, true, 640, 480, true);
            add(this.bgImage);
        }

        public function addClickZone(origin:FlxPoint, size:FlxPoint,
                                     clickFn:Function, contactFn:Function):DHButton
        {
            var _clickZone:DHButton = new DHButton(origin.x, origin.y, "", clickFn);
            var _color:uint = 0x00000000;
            CONFIG::debugging {
                _color = 0x77FF0000;
            }
            _clickZone.makeGraphic(size.x, size.y, _color);
            _clickZone.immovable = true;
            add(_clickZone);
            this.zones[_clickZone] = contactFn;
            return _clickZone;
        }

        public function conversation(origin:FlxPoint, size:FlxPoint, _text:String, _this:MapRoom, ... args):Function{
            function inner():void
            {
                activeSelectorBox = new SelectorTextBox(origin, size, _text);
                activeSelectorBox.setup.apply(null, args);
                activeSelectorBox.selectionDelegate = _this;
            }
            return inner;
        }

        public function colliderConversation(origin:FlxPoint, size:FlxPoint, _text:String,
                                             _this:MapRoom=null, ... args):Function{
            function inner(p:FlxSprite,b:FlxSprite):void
            {
                activeSelectorBox = new SelectorTextBox(origin, size, _text);
                activeSelectorBox.setup.apply(null, args);
                activeSelectorBox.selectionDelegate = _this;
            }
            return inner;
        }

        public function makeTextBoxCallback(origin:FlxPoint, size:FlxPoint, _text:String, _callback:Function=null):Function
        {
            function inner(p:FlxSprite, b:FlxSprite):void
            {
                FlxG.state.remove(activeTextBox);
                activeTextBox = new TextBox(origin, size, _text);
                if (_callback != null) {
                    _callback(activeTextBox);
                }
            }
            return inner;
        }

        public function endingChecker():void{
            if(HouseMap.getInstance().endingCounter >= 3){
                if(HouseMap.getInstance().CultureRoom){
                    if(HouseMap.getInstance().KidsRoom){
                        if(HouseMap.getInstance().LangRoom){
                            ending = true;
                        }
                    }
                }
            }
        }

        public function didSelectTextOption(idx:Number, item:FlxText,
                                            selector:SelectorTextBox):void
        {}

        public function getKeys(dictionary:Dictionary):Array
        {
            var keys:Array = [];
            for (var key:* in dictionary) keys.push(key);
            return keys;
        }
    }
}
