package
{
    import org.flixel.*;

    public class LobbyRoom extends MapRoom
    {
        [Embed(source="../assets/Room-1-Lobby.png")] private var ImgRoomLobby:Class;
        public var debugText:FlxText;
        public var player:Player;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomLobby);

            FlxG.mouse.show();

            debugText = new FlxText(100,100,FlxG.width,"");
            add(debugText);

            player = new Player(20,150);
            add(player);

            //receptionist = new NPC(400,280,200,200);

            this.addClickZone(
                new FlxPoint(100, 100),
                new FlxPoint(40, 40),
                doorWasClicked
            );

            this.addClickZone(
                new FlxPoint(400,280),
                new FlxPoint(200,200),
                conversation(10,10,"Hello I am a text box!")
            );
        }

        override public function update():void{
            super.update();
            FlxG.collide();
        }

        private function doorWasClicked():void
        {
            FlxG.switchState(new UpstairsRoom());
        }
    }
}
