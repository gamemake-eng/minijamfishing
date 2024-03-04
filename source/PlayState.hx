package;

//credit https://freesound.org/people/RHumphries/sounds/979/

import haxefmod.FmodManager;
import haxefmod.FmodEvents.FmodCallback;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.util.FlxCollision;
import flixel.FlxG;
import flixel.util.FlxColor;
import haxe.io.Path;
import objects.Player;
import shader.Water;
import shader.BlueTint;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;
import flixel.group.FlxGroup;


import openfl.Assets;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.Lib;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;

import FmodConstants.FmodSFX;

import FmodConstants.FmodSongs;

class PlayState extends FlxState
{
	var player:Player;
	var walls:FlxTilemap;
	var watershader:Water;
	var tintshader:BlueTint;
	var shaderTimer:Float = 0;
	var pow:Float = 1.0;
	var tileSize:Int;
	var mapW:Int;
	var mapH:Int;

	var trash:FlxTypedGroup<objects.Trash>;
	var fish:FlxTypedGroup<objects.Fish>;

	var line:FlxSprite;
	var linePos:FlxPoint;
	var linePosG:FlxPoint;

	var corpse:FlxSprite;
	var corpseGrab:Bool = false;

	var speed:Float = 0.1;



	override public function onFocus() {
        super.onFocus();
        FmodManager.SetEventParameterOnSong("HighPass", 0);
    }

    override public function onFocusLost() {
        super.onFocusLost();
        FmodManager.SetEventParameterOnSong("HighPass", 1);
    }

	override public function create()
	{
		super.create();

		line = new FlxSprite();
        

        linePos = FlxPoint.get(0,0);
        linePosG = FlxPoint.get(0,0);

		var tiledLevel:TiledMap = new TiledMap("assets/data/test.tmx");

		var tilesheetPath:String;
		tilesheetPath = "assets/images/"+Path.withoutDirectory( tiledLevel.tilesetArray[0].imageSource);

		tileSize = tiledLevel.tileWidth;
		mapW = tiledLevel.width;
		mapH = tiledLevel.height;

		line.makeGraphic(FlxG.width, (tileSize*mapH), 0, true);
        add(line);

		FlxG.worldBounds.set(0,0,tileSize*mapW,tileSize*mapH);
		FlxG.worldDivisions=10;

		trash = new FlxTypedGroup<objects.Trash>();
		fish = new FlxTypedGroup<objects.Fish>();

		for (layer in tiledLevel.layers)
		{
		  if(layer.type==TiledLayerType.TILE){
		    var l:TiledTileLayer=cast (layer, TiledTileLayer);
		    walls = new FlxTilemap();

		    walls.loadMapFromArray(l.tileArray, mapW, mapH,tilesheetPath, tileSize, tileSize, FlxTilemapAutoTiling.OFF, 1,1,1);
		  }

		  if (layer.type == TiledLayerType.OBJECT) {
		  	var l:TiledObjectLayer=cast (layer, TiledObjectLayer);
		  	switch(layer.name)
		  	{
		  		case 'trash': {

		  			for (o in l.objects) {
		  				trash.add(new objects.Trash(o.x, o.y));
		  			}

		  		}

		  		case 'fish': {

		  			for (o in l.objects) {
		  				fish.add(new objects.Fish(o.x, o.y));
		  			}

		  		}

		  		case 'body': {
		  			for(o in l.objects)
		  			{
		  				corpse = new FlxSprite(o.x,o.y);
		  				corpse.loadGraphic("assets/images/corpse.png");
		  				add(corpse);
		  			}
		  		}
		  	}
		  }
		    
	  	}


		player = new Player(0,0);

		add(player);
		add(walls);
		add(trash);
		add(fish);
		

		watershader = new Water(90);

		tintshader = new BlueTint();

		FlxG.game.setFilters([new ShaderFilter(tintshader), new ShaderFilter(watershader)]);

		FmodManager.SetEventParameterOnSong("Clean", 0);

		FlxG.camera.fade(FlxColor.BLACK, 1, true);

	}

	override public function update(elapsed:Float)
	{

		linePosG.x = player.x + player.origin.x;
		linePosG.y = player.y + 60;

		linePos.x += (linePosG.x - linePos.x) * speed;
		linePos.y += (linePosG.y - linePos.y) * speed;

		shaderTimer += elapsed;
		if (shaderTimer > Math.PI)
		{
    		shaderTimer -= Math.PI;
		}
		watershader.uTime.value = [shaderTimer];

		tintshader.power.value = [pow];

		pow = player.y/480;
		pow = FlxMath.bound(pow, 1.0, 20.0)+2.0;

		player.y = FlxMath.bound(player.y, player.height+1, (tileSize*mapH)-player.height);

		FmodManager.SetEventParameterOnSong("Depth", (player.y/(((tileSize*(mapH/4))-player.height)))*100);

		FlxG.camera.color = FlxColor.BLUE;

		FlxG.camera.follow(player,FlxCameraFollowStyle.SCREEN_BY_SCREEN, 0.1);

		if(FlxG.collide(player,walls))
		{
			resetGame();
		}

		if(FlxG.collide(player,corpse))
		{
			corpseGrab = true;
		}
		for(t in trash)
		{
			if (FlxCollision.pixelPerfectCheck(t, player, 1)) {
				resetGame();
			}
		}

		for(t in fish)
		{
			if (FlxCollision.pixelPerfectCheck(t, player, 1)) {
				resetGame();
			}
		}
		


		if(corpseGrab)
		{
			corpse.x = linePos.x;
			corpse.y = linePos.y;
			corpse.x = (corpse.x - corpse.origin.x)-10;
			corpse.y = corpse.y - corpse.origin.y;
		}

		FlxSpriteUtil.fill(line, 0);		

		FlxSpriteUtil.drawLine(line, player.x + player.origin.x, player.y + player.origin.y, linePos.x, linePos.y, {
            thickness: 3,
            color: 0xFF00FF00
        });

		super.update(elapsed);
		FmodManager.Update();
	}

	function resetGame() {
		
		if (!player.isLikeReallyDead) {
			for (i in 0 ... 10) {
				add(new objects.Scrap(player.x + player.origin.x, player.y + player.origin.y));
			}
			FmodManager.StopSound("engine");
			FmodManager.PlaySoundOneShot(FmodSFX.Die);
			player.kill();
			player.isLikeReallyDead = true;
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function(){
    			FlxG.switchState(new PlayState());
    		});
		}
		
		//FlxG.switchState(new PlayState());
	}

	
}
