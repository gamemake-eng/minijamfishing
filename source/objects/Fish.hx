package objects;
import flixel.FlxSprite;
class Fish extends FlxSprite {
	var images = ["fish1","fish2","fish3","fish4","fish5","fish6","fish7"];
	var speed = 100;
	public function new(x:Float, y:Float) {
		super(x,y);
		
		
		loadGraphic("assets/images/"+images[flixel.FlxG.random.int(0,images.length-1)]+".png");
		scale.x = 2;
		scale.y = 2;
		width = width*2;
		height = height*2;

		velocity.x = -speed;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);

		facing = LEFT;
		
	}

	override public function update(elapsed:Float) {
		

		if (x < 0) {
			velocity.x = speed;
			facing = RIGHT;
		}

		if (x > 640-width) {
			velocity.x = -speed;
			facing = LEFT;
		}
		super.update(elapsed);
	}
}