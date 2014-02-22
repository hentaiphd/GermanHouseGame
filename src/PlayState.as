package
{
    import org.flixel.*;

	public class PlayState extends FlxState
	{
        public var debugText:FlxText;
        public var player:Player;

		override public function create():void
		{
            FlxG.mouse.show();
            debugText = new FlxText(100,100,FlxG.width,"");
            add(debugText);

			player = new Player(20,150);
            add(player);
		}

        override public function update():void{
            super.update();
        }
	}
}
