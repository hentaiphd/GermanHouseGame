package
{
    import org.flixel.*;

    public class LobbyRoom extends MapRoom
    {
        [Embed(source="../assets/Room-1-Lobby.png")] private var ImgRoomLobby:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomLobby);
        }
    }
}
