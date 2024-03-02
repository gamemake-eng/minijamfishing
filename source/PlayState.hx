package;

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
import flixel.math.FlxMath;

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


		FmodManager.PlaySoundOneShot(FmodSFX.Engine);

		var tiledLevel:TiledMap = new TiledMap("assets/data/test.tmx");

		var tilesheetPath:String;
		tilesheetPath = "assets/images/"+Path.withoutDirectory( tiledLevel.tilesetArray[0].imageSource);

		tileSize = tiledLevel.tileWidth;
		mapW = tiledLevel.width;
		mapH = tiledLevel.height;

		FlxG.worldBounds.set(-10,-10,tileSize*mapW+10,tileSize*mapH+10);
		FlxG.worldDivisions=10;

		for (layer in tiledLevel.layers)
		{
		  if(layer.type==TiledLayerType.TILE){
		    var l:TiledTileLayer=cast (layer, TiledTileLayer);
		    walls = new FlxTilemap();

		    walls.loadMapFromArray(l.tileArray, mapW, mapH,tilesheetPath, tileSize, tileSize, FlxTilemapAutoTiling.OFF, 1,1,1);
		  }
		    
	  	}


		player = new Player(0,0);

		add(player);
		add(walls);

		watershader = new Water(90);

		tintshader = new BlueTint();

		FlxG.game.setFilters([new ShaderFilter(watershader), new ShaderFilter(tintshader)]);

	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FmodManager.Update();

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

		FlxG.camera.color = FlxColor.BLUE;

		FlxG.camera.follow(player,FlxCameraFollowStyle.SCREEN_BY_SCREEN, 0.1);

		if(FlxG.collide(player,walls))
		{
			resetGame();
		}
	}

	function resetGame() {
		FlxG.switchState(new PlayState());
	}

	
}
