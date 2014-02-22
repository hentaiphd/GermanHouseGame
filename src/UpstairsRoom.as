package
{
    import org.flixel.*;

    public class UpstairsRoom extends MapRoom
    {
        [Embed(source="../assets/Room-3-Upper-Level.png")] private var ImgRoomUpperLevel:Class;

        override public function create():void
        {
            super.create();
            this.setupBackground(ImgRoomUpperLevel);
        }
    }
}
