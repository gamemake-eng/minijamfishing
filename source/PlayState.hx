package;

import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import objects.Player;
class PlayState extends FlxState
{
	var player:Player;
	var walls:FlxTilemap;
	override public function create()
	{
		super.create();
		player = new Player(0,0);
		walls = new FlxTilemap();
		walls.loadMapFromCSV("assets/data/lv1.csv", "assets/images/wall.png",16,16);


		add(player);
		add(walls);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		flixel.FlxG.camera.follow(player,FlxCameraFollowStyle.SCREEN_BY_SCREEN, 0.1);

		flixel.FlxG.overlap(player,walls,resetGame);
	}

	function resetGame() {
		player.x = player.checkpoint.x;
		player.y = player.checkpoint.y;
	}

	
}
