package
{
    import flash.utils.Dictionary;
    import org.flixel.*;

    public class MapRoom extends FlxState
    {
        private var bgImage:FlxSprite;
        private var zones:Dictionary;

        public var activeSelectorBox:SelectorTextBox = null;
        public var player:Player;
        public var ending:Boolean = false;
        public var debugText:FlxText;

        public function MapRoom()
        {
            this.zones = new Dictionary();
        }

        override public function create():void
        {
            super.create();
            FlxG.mouse.show();
            endingChecker();
        }

        override public function update():void
        {
            super.update();
            if(this.activeSelectorBox != null){
                this.activeSelectorBox.update();
            }

            for (var k:Object in this.zones) {
                var contactFn:Function = this.zones[k];
                var _clickZone:DHButton = k as DHButton;
                this.doContact(_clickZone, contactFn);
            }
        }

        private function doContact(_clickZone:DHButton, contactFn:Function):void
        {
            function _callback(a:FlxSprite, b:FlxSprite):void
            {
                if (_clickZone.wasClicked) {
                    player.collideFn();
                    contactFn(a, b);
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
            _clickZone.makeGraphic(size.x, size.y, 0x77FF0000);
            _clickZone.immovable = true;
            add(_clickZone);
            this.zones[_clickZone] = contactFn;
            return _clickZone;
        }

        public function conversation(x:int, y:int, _text:String,
                                     _label:String, opts:Array = null,
                                     _this:MapRoom=null):Function{
            function inner():void
            {
                activeSelectorBox = new SelectorTextBox(x, y, _text, _label, opts);
                activeSelectorBox.selectionDelegate = _this;
            }
            return inner;
        }

        public function colliderConversation(x:int, y:int, _text:String,
                                             _label:String, opts:Array = null,
                                             _this:MapRoom=null):Function{
            function inner(p:FlxSprite,b:FlxSprite):void
            {
                activeSelectorBox = new SelectorTextBox(x, y, _text, _label, opts);
                activeSelectorBox.selectionDelegate = _this;
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
        {
        }
    }
}
