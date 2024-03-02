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

	var speed:Float = 20;
	var max:Float = 100;
	
	public function new(x:Float, y:Float) {
		super(x,y);
		makeGraphic(32,16, flixel.util.FlxColor.BLUE);
		maxVelocity.x = maxVelocity.y = max;
		drag.x = drag.y = 200;

		checkpoint = FlxPoint.get(0,0);
	}

	override public function update(elapsed:Float) {
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
		}
		if (right) {
			velocity.x += speed;
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

	override public function destroy()
	{
		checkpoint.put();
		super.destroy(elapsed);
	}
	
}