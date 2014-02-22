package{
    import org.flixel.*;

    public class NPC extends FlxSprite{

        public function NPC(x:int, y:int){
            super(x, y);
            this.makeGraphic(20,20);
            this.color = 0xffA89EFF;
        }

        override public function update():void{
            super.update();
        }
    }
}