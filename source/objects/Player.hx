package objects;


import haxefmod.FmodManager;
import haxefmod.FmodEvents.FmodCallback;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import FmodConstants.FmodSFX;
import FmodConstants.FmodSongs;

class Player extends FlxSprite {

	var up:Bool;
	var down:Bool;
	var left:Bool;
	var right:Bool;

	var upP:Bool;
	var downP:Bool;
	var leftP:Bool;
	var rightP:Bool;

	var upR:Bool;
	var downR:Bool;
	var leftR:Bool;
	var rightR:Bool;

	public var isLikeReallyDead:Bool = false;

	var speedVol:Float;

	public var checkpoint:FlxPoint;

	var speed:Float = 5;
	var max:Float = 200;
	
	public function new(x:Float, y:Float) {
		super(x,y);
		loadGraphic("assets/images/submarine.png");
		maxVelocity.x = maxVelocity.y = max;
		drag.x = drag.y = 100;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);

		checkpoint = FlxPoint.get(0,0);

		
		FmodManager.PlaySoundAndAssignId(FmodSFX.Engine, "engine");
	}

	override public function update(elapsed:Float) {
		angle = velocity.x/10;
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, A]);
		left = FlxG.keys.anyPressed([LEFT, S]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		upP = FlxG.keys.anyJustPressed([UP, W]);
		downP = FlxG.keys.anyJustPressed([DOWN, A]);
		leftP = FlxG.keys.anyJustPressed([LEFT, S]);
		rightP = FlxG.keys.anyJustPressed([RIGHT, D]);

		upR = FlxG.keys.anyJustReleased([UP, W]);
		downR = FlxG.keys.anyJustReleased([DOWN, A]);
		leftR = FlxG.keys.anyJustReleased([LEFT, S]);
		rightR = FlxG.keys.anyJustReleased([RIGHT, D]);

		if (up) {
			velocity.y += -speed;
		}
		if (down) {
			velocity.y += speed;
		}
		if (left) {
			velocity.x += -speed;
			facing = LEFT;
		}
		if (right) {
			velocity.x += speed;
			facing = RIGHT;
		}

		/*if (rightP || leftP || upP || downP)
		{
			FmodManager.PlaySoundAndAssignId(FmodSFX.Engine, "engine");
		}

		if (rightR || leftR || upR || downR)
		{
			FmodManager.StopSound("engine");
		}*/

		speedVol = Math.abs(velocity.x);


		if (speedVol > max) {
			speedVol = max;
		}

		if (speedVol < 0) {
			speedVol = 0;
		}

		FmodManager.SetEventParameterOnSound("engine", "speed", speedVol);


		

		if (x < 2) {
			x = 2;
		}

		if (y < 2) {
			y = 2;
		}
		if (x > (640-width)-2) {
			x = (640-width)-2;
		}

		/*if (y > (480-height)-2) {
			y = (480-height)-2;
		}*/

		

		super.update(elapsed);
	}

	override public function destroy() {

		FmodManager.ReleaseSound("engine");

		super.destroy();
	}
	
	
}