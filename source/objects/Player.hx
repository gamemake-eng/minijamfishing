package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Player extends FlxSprite {

	var up:Bool;
	var down:Bool;
	var left:Bool;
	var right:Bool;

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
	}

	override public function update(elapsed:Float) {
		angle = velocity.x/10;
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, A]);
		left = FlxG.keys.anyPressed([LEFT, S]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

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

	
	
}