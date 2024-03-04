package;

import haxefmod.FmodManager;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;

import FmodConstants.FmodSFX;

import FmodConstants.FmodSongs;

class EndState extends FlxState {
	override public function create():Void {
        super.create();

        var logo = new FlxSprite(0,0);
        logo.loadGraphic("assets/images/gravestone.png");
        logo.screenCenter();
        

        var loadingText = new FlxText(0, 0, "Fredrick was found");
        loadingText.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, NONE, FlxColor.BLACK);
        loadingText.x = (FlxG.width/2) - loadingText.width/2;
        loadingText.y = (FlxG.height/2) - loadingText.height/2;
        loadingText.y -= 200;

        var startText = new FlxText(0, 0, "Press space to restart");
        startText.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, NONE, FlxColor.BLACK);
        startText.x = (FlxG.width/2) - startText.width/2;
        startText.y = (FlxG.height/2) - startText.height/2;
        startText.y += 200;


        add(logo);
		add(loadingText);       
		add(startText);   

        FmodManager.SetEventParameterOnSong("Clean", 100);



    }
    override public function update(elapsed:Float):Void {

    	if (FlxG.keys.anyJustPressed([SPACE])) {
    		FlxG.camera.fade(FlxColor.BLACK, 1, false, function(){
    			FlxG.switchState(new PlayState());
    		});
    	}

    	super.update(elapsed);
    	FmodManager.Update();
        
    }
}