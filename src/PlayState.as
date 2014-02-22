package
{
    import org.flixel.*;

	public class PlayState extends FlxState
	{
        public var debugText:FlxText;
        public var player:Player;
        public var textBox:TextBox;
        public var npc:NPC;

		override public function create():void
		{
            FlxG.mouse.show();
            debugText = new FlxText(100,100,FlxG.width,"");
            add(debugText);

			player = new Player(20,150);
            add(player);

            npc = new NPC(50,150);
            add(npc);

            textBox = new TextBox(10,10,"Hello I am a text box!");
		}

        override public function update():void{
            super.update();
        }
	}
}
