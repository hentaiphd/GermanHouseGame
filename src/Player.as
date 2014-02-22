package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        private var runSpeed:Number = 1;
        public var walkTarget:FlxPoint;
        private var walking:Boolean = false;

        public function Player(x:int, y:int){
            super(x, y);
            this.makeGraphic(20,20,0xffFFDABA);
            walkTarget = new FlxPoint(x,y);
        }

        override public function update():void{
            super.update();
            borderCollide();

            if(FlxG.mouse.justPressed()){
                walkTarget.x = FlxG.mouse.x;
                walkTarget.y = FlxG.mouse.y;
                this.walking = true;
            }

            if(this.walking) {
                this.walk();
            }
        }

        public function collideFn():void
        {
            this.walking = false;
        }

        public function walk():void{
            var distX:Number = walkTarget.x - this.x;
            var distY:Number = walkTarget.y - this.y;
            this.x += distX / 100;
            this.y += distY / 100;
        }

        public function borderCollide():void{
            if(this.x >= FlxG.width - width)
                this.x = FlxG.width - width;
            if(this.x <= 0)
                this.x = 0;
            if(this.y >= FlxG.height - height)
                this.y = FlxG.height - height;
            if(this.y <= 0)
                this.y = 0;
        }
    }
}
