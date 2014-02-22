package
{
    import org.flixel.*;

    public class HouseMap
    {

        private static var _instance:HouseMap;

        public function setup():void
        {
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
    }
}
