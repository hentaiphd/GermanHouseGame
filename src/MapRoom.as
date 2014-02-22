package
{
    import org.flixel.*;

    public class MapRoom extends FlxState
    {
        private var bgImage:FlxSprite;

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

        public function addClickZone(origin:FlxPoint, size:FlxPoint, clickFn:Function):void
        {
            var _clickZone:FlxButton = new FlxButton(origin.x, origin.y, "", clickFn);
            _clickZone.makeGraphic(size.x, size.y, 0x77FF0000);
            add(_clickZone);
        }
    }
}
