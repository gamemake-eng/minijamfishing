package objects;
import flixel.FlxSprite;
class Trash extends FlxSprite {
	var images = ["trash1","trash2","trash3","trash4"];
	var speed:Float;
	public function new(x:Float, y:Float) {
		super(x,y);
		
		speed = flixel.FlxG.random.float(0.1,1);
		loadGraphic("assets/images/"+images[flixel.FlxG.random.int(0,images.length-1)]+".png");
		scale.x = 2;
		scale.y = 2;
		width = width*2;
		height = height*2;
		
	}

	override public function update(elapsed:Float) {
		angle += speed;
		super.update(elapsed);
	}
}