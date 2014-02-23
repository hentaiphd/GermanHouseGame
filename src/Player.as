package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source="../assets/Kid.png")] private var ImgKid:Class;

        private var runSpeed:Number = 1;
        private var walkDistance:Number = 0;
        private var walkTarget:DHPoint;
        private var walkDirection:DHPoint = null;
        private var walking:Boolean = false;
        private var walkSpeed:Number = 4;
        private var footPos:FlxPoint;
        private var heightDivisor:Number = 2;
        private var debugText:FlxText;

        public var pos:FlxPoint;

        public function Player(x:int, y:int){
            super(x, y);
            this.loadGraphic(ImgKid, true, true, 116, 188, true);
            this.offset.y = this.height - this.height/this.heightDivisor;
            this.height /= this.heightDivisor;
            this.walkTarget = new DHPoint(0, 0);

            addAnimation("stand", [0], 12, true);
            addAnimation("walk", [1,2,3,4], 12, true);
            addAnimation("walkdown", [5,6,7,8,9], 12, true);
            addAnimation("walkup", [10,11,12,13,14], 12, true);

            debugText = new FlxText(100,100,100,"YOOO");
            debugText.color = 0xff000000;
            FlxG.state.add(debugText);
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

            if(walkDirection != null){
                if(Math.abs(walkDirection.y) > Math.abs(walkDirection.x)){
                    if(walkDirection.y < 0){
                        this.facing = UP;
                    } else {
                        this.facing = DOWN;
                    }
                } else {
                    if(walkDirection.x > 0){
                        this.facing = RIGHT;
                    } else {
                        this.facing = LEFT;
                    }
                }
            }

            if (new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y)._length() < 3) {
                this.walking = false;
            }

            if(this.walking) {
                this.walk();
                debugText.text = this.facing.toString();
                if(this.facing == LEFT){
                    this.play("walk");
                } else if (this.facing == RIGHT){
                    this.play("walk");
                } else if(this.facing == UP){
                    this.play("walkup");
                } else if(this.facing == DOWN){
                    this.play("walkdown");
                }

            } else {
                this.play("stand");
            }
        }

        public function collideFn():void
        {
            this.walking = false;
        }

        public function walk():void{
            walkDirection = new DHPoint(walkTarget.x-footPos.x, walkTarget.y-footPos.y).normalized();
            var walkX:Number = this.walkDirection.x * this.walkSpeed;
            var walkY:Number = this.walkDirection.y * this.walkSpeed;
            this.x += walkX;
            this.y += walkY;
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
