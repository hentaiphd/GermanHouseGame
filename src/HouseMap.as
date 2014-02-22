package
{
    import org.flixel.*;

    public class HouseMap
    {
        [Embed(source="../assets/Room-1-Lobby.png")] private var ImgRoomLobby:Class;

        private static var _instance:HouseMap;

        public function HouseMap(){
            if(_instance){
                throw new Error("Singleton... use getInstance()");
            }
            _instance = this;
        }

        public static function getInstance():HouseMap{
            if(!_instance){
                new HouseMap();
            }
            return _instance;
        }
    }
}
