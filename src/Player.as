package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        private var runSpeed:Number = 1;
        private var walkDistance:Number = 0;
        private var walkTarget:DHPoint;
        private var walkDirection:DHPoint;
        private var walking:Boolean = false;
        private var walkSpeed:Number = 4;

        public function Player(x:int, y:int){
            super(x, y);
            this.makeGraphic(20,20,0xffFFDABA);
            this.walkTarget = new DHPoint(0, 0);
        }

        override public function update():void{
            super.update();
            borderCollide();

            var pos:FlxPoint = new FlxPoint(this.x, this.y);

            if(FlxG.mouse.justPressed()){
                walkTarget = new DHPoint(FlxG.mouse.x, FlxG.mouse.y);
                this.walking = true;
                walkDistance = new DHPoint(walkTarget.x-pos.x, walkTarget.y-pos.y)._length();
                walkDirection = new DHPoint(walkTarget.x-pos.x, walkTarget.y-pos.y).normalized();
            }

            if (new DHPoint(walkTarget.x-pos.x, walkTarget.y-pos.y)._length() < 3) {
                this.walking = false;
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
            this.x += this.walkDirection.x * this.walkSpeed;
            this.y += this.walkDirection.y * this.walkSpeed;
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
