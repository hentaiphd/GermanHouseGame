package {
    import org.flixel.*;

    public class TimedState extends FlxState {
        public var timeFrame:Number = 0;
        public var timeSec:Number = 0;
        public var endTime:Number = -1;

        public static const fpSec:Number = 100;

        override public function update():void{
            super.update();
            timeFrame++;

            if(timeFrame%fpSec == 0){
                timeSec++;
            }

            if(this.endTime != -1 && timeSec == this.endTime) {
                this.endCallback();
            }
        }

        public function endCallback():void{}
    }
}
