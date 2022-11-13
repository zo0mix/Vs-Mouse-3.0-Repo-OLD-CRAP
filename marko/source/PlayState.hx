package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouse;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var marko:FlxSprite;
	var bg:FlxSprite;
	var points:Int = 0;
	var pointsText:FlxText;

	override public function create()
	{
		// bg = new FlxSprite(0, 0).loadGraphic();
		marko = new FlxSprite(0, 0).loadGraphic('assets/images/mark.png');
		marko.screenCenter();
		marko.setGraphicSize(Std.int(marko.height * 1.3));
		add(marko);

		pointsText = new FlxText(100, -200);
		pointsText.text('Points: ' + points);
		add(pointsText);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		//	trace("x = " + FlxG.mouse.x + ' y = ' + FlxG.mouse.y);
		super.update(elapsed);

		if (FlxG.mouse.x > 214 && FlxG.mouse.x < 405 && FlxG.mouse.y > 54 && FlxG.mouse.y < 434)
		{
			if (FlxG.mouse.justPressed)
			{
				points++;
				trace(points);
			}
		}
	}
}
