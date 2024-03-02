package;

import haxefmod.FmodManager;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

class FmodLoadState extends FlxState {
	override public function create():Void {
        FmodManager.Initialize();

        var loadingText = new FlxText(0, 0, "Loading...");
        loadingText.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, NONE, FlxColor.BLACK);
        loadingText.x = (FlxG.width/2) - loadingText.width/2;
        loadingText.y = (FlxG.height/2) - loadingText.height/2;
        add(loadingText);
    }
    override public function update(elapsed:Float):Void {
        if(FmodManager.IsInitialized()){
            FlxG.switchState(new PlayState());
        }
    }
}