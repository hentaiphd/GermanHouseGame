package
{
    import org.flixel.*;

    public class HouseMap
    {
        private static var _instance:HouseMap;

        public var CultureRoom:Boolean = false;
        public var KidsRoom:Boolean = false;
        public var LangRoom:Boolean = false;
        public var endingCounter:Number = 0;
        public var hasSeenIntroSequence:Boolean = false;
        public var DEBUG:Boolean = true;

        private var exitPoints:Array;

        public static const LANG_DE:int = 1;
        public static const LANG_EN:int = 2;
        public var currentLanguage:int = LANG_DE;

        public function setup():void
        {
            this.exitPoints = new Array();
        }

        public function HouseMap(){
            if(_instance){
                throw new Error("Singleton... use getInstance()");
            }
            _instance = this;
            this.setup();
        }

        public static function getInstance():HouseMap{
            if(!_instance){
                new HouseMap();
            }
            return _instance;
        }

        public function popExitPoint():FlxPoint
        {
            if (this.exitPoints.length == 0) {
                return null;
            }
            return this.exitPoints.pop() as FlxPoint;
        }

        public function pushExitPoint(pt:FlxPoint):void
        {
            this.exitPoints.push(pt);
        }
    }
}
