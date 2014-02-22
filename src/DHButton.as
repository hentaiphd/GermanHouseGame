package
{
    import org.flixel.*;

    public class DHButton extends FlxButton
    {
        public var wasClicked:Boolean = false;

        public function DHButton(x:Number=0,y:Number=0,Label:String=null,OnClick:Function=null)
        {
            super(x, y, Label, OnClick);
            function _callback():void
            {
                wasClicked = true;
                OnClick();
            }
            onUp = _callback;
        }
    }
}
