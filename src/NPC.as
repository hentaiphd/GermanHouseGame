package{
    import org.flixel.*;

    public class NPC extends FlxSprite{

        public function NPC(x:int, y:int, w:Number, h:Number){
            super(x, y);
            this.makeGraphic(w,h);
            this.color = 0xffA89EFF;
        }

        override public function update():void{
            super.update();
        }
    }
}