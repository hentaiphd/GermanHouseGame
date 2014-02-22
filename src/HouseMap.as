package
{
    import org.flixel.*;

    public class HouseMap
    {
        [Embed(source="../assets/Room-1-Lobby.png")] private var ImgRoomLobby:Class;

        private static var _instance:HouseMap;

        public function HouseMap(s:SingletonEnforcer) {
            if (s == null) throw new Error("Singleton, use HouseMap.instance");
        }

        public static function get instance():HouseMap
            if (_instance == null) _instance = new HouseMap(new SingletonEnforcer());
            return _instance;
        }
    }
}
class SingletonEnforcer {}
