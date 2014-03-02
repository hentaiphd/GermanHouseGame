package
{
    import org.flixel.*;

    public class DHButton extends FlxButton
    {
        public var wasClicked:Boolean = false;

        public function DHButton(x:Number=0,y:Number=0,Label:String=null,OnClick:Function=null)
        {
            super(x, y, Label, OnClick);
            var _callback:Function = function __callback():void
            {
                wasClicked = true;
                if (OnClick != null) {
                    OnClick();
                }
            }
            onUp = _callback;
        }

        override protected function updateButton():void
        {
            if(true)
            {
                if(cameras == null)
                    cameras = FlxG.cameras;
                var camera:FlxCamera;
                var i:uint = 0;
                var l:uint = cameras.length;
                var offAll:Boolean = true;
                while(i < l)
                {
                    camera = cameras[i++] as FlxCamera;
                    FlxG.mouse.getWorldPosition(camera,_point);
                    if(overlapsPoint(_point,true,camera))
                    {
                        offAll = false;
                        if(FlxG.mouse.justPressed())
                        {
                            status = PRESSED;
                            if(onDown != null)
                                onDown();
                            if(soundDown != null)
                                soundDown.play(true);
                        }
                        if(status == NORMAL)
                        {
                            status = HIGHLIGHT;
                            if(onOver != null)
                                onOver();
                            if(soundOver != null)
                                soundOver.play(true);
                        }
                    }
                }
                if(offAll)
                {
                    if(status != NORMAL)
                    {
                        if(onOut != null)
                            onOut();
                        if(soundOut != null)
                            soundOut.play(true);
                    }
                    status = NORMAL;
                }
            }

            if(label != null)
            {
                label.x = x;
                label.y = y;
            }
            if(labelOffset != null)
            {
                label.x += labelOffset.x;
                label.y += labelOffset.y;
            }

            if((status == HIGHLIGHT) && _onToggle)
                frame = NORMAL;
            else
                frame = status;
        }
    }
}
