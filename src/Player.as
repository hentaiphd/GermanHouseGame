package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source="../assets/Kid.png")] private var ImgKid:Class;

        private var runSpeed:Number = 1;
        private var walkDistance:Number = 0;
        private var walkTarget:DHPoint;
        private var walkDirection:DHPoint;
        private var walking:Boolean = false;
        private var walkSpeed:Number = 4;

        public var pos:FlxPoint;
        public var footPos:FlxPoint;

        public function Player(x:int, y:int){
            super(x, y);
            this.loadGraphic(ImgKid, true, true, 72, 185, true);
            this.walkTarget = new DHPoint(0, 0);
        }

        override public function update():void{
            super.update();
            borderCollide();

            pos = new FlxPoint(this.x, this.y);
            footPos = new FlxPoint(this.x+this.width/2, this.y+this.height);

            if(FlxG.mouse.justPressed()){
                walkTarget = new DHPoint(FlxG.mouse.x, FlxG.mouse.y);
                this.walking = true;
                walkDistance = new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y)._length();
                walkDirection = new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y).normalized();
            }

            if (new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y)._length() < 3) {
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
            walkDirection = new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y).normalized();
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
