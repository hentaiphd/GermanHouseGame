package
{
    import org.flixel.*;

    public class MapRoom extends FlxState
    {
        private var bgImage:FlxSprite;
        public var textBox:TextBox;

        public function MapRoom()
        {

        }

        override public function create():void
        {
            super.create();
            FlxG.mouse.show();
        }

        override public function update():void
        {
            super.update();
        }

        public function setupBackground(image:Class):void
        {
            this.bgImage = new FlxSprite(0, 0);
            this.bgImage.loadGraphic(image, true, true, 640, 480, true);
            add(this.bgImage);
        }

        public function addClickZone(origin:FlxPoint, size:FlxPoint, clickFn:Function):FlxButton
        {
            var _clickZone:FlxButton = new FlxButton(origin.x, origin.y, "", clickFn);
            _clickZone.makeGraphic(size.x, size.y, 0x77FF0000);
            _clickZone.immovable = true;
            add(_clickZone);
            return _clickZone;
        }

        public function conversation(x:int, y:int, _text:String):Function{
            function inner():void
            {
                textBox = new TextBox(x, y, _text);
            }
            return inner;
        }

        public function colliderConversation(x:int, y:int, _text:String):Function{
            function inner(p:FlxSprite,b:FlxSprite):void
            {
                textBox = new TextBox(x, y, _text);
            }
            return inner;
        }
    }
}
