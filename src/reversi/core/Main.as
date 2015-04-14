/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.core
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import starling.core.Starling;

	[SWF(width="480", height="600", frameRate="60", backgroundColor="#003300")]

	public class Main extends Sprite
	{
		public static const SCREEN_WIDTH:int = 640;
		public static const SCREEN_HEIGHT:int = 480;
		{
			public function Main()
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;

				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;

				var mStarling:Starling = new Starling(Game, stage);

				mStarling.antiAliasing = 1;

				mStarling.start();
			}
		}
	}
}
