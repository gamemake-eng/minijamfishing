package;

import haxefmod.FmodManager;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;

class FmodLoadState extends FlxState {
    var startTimer:Bool;
    var timer:Int = 210;
	override public function create():Void {
        FmodManager.Initialize();

        var logo = new FlxSprite(0,0);
        logo.loadGraphic("assets/images/FMOD.png");
        logo.scale.x = 0.5;
        logo.scale.y = 0.5;
        logo.screenCenter();

        /*var loadingText = new FlxText(0, 0, "Loading...");
        loadingText.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, NONE, FlxColor.BLACK);
        loadingText.x = (FlxG.width/2) - loadingText.width/2;
        loadingText.y = (FlxG.height/2) - loadingText.height/2;*/
        add(logo);
    }
    override public function update(elapsed:Float):Void {
        if(FmodManager.IsInitialized()){
            startTimer = true;
            
        }

        if (timer < 0 ) {
            FlxG.switchState(new PlayState());
        }

        if (startTimer) {
            timer -= 1;
        }
    }
}