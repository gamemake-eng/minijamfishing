package objects;
import flixel.FlxSprite;
class Scrap extends FlxSprite {
	public function new(x:Float, y:Float) {
		super(x,y);
		
		
		makeGraphic(16,16,flixel.util.FlxColor.YELLOW);
		

		velocity.x = flixel.FlxG.random.float(-100, 100);

		velocity.y = flixel.FlxG.random.float(-100, 100);
		
	}

	override public function update(elapsed:Float) {
		
		super.update(elapsed);
	}
}