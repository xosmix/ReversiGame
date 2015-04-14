/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package view
{
	import core.AssetsManager;

	import model.PlayerHelper;

	import starling.display.DisplayObjectContainer;

	import starling.display.Image;
	import starling.text.TextField;

	public class ScoreGameView extends DisplayObjectContainer
	{
		private var _blackScore:TextField;
		private var _whiteScore:TextField;
		private var _whiteStone:Image;
		private var _blackStone:Image;

		public function ScoreGameView()
		{
			initBackground();
			initTextFields();
			initStones();
		}

		private function initBackground():void
		{
			var background:Image = new Image(AssetsManager.getTextureByName("score"));
			addChild(background);
		}



		private function initTextFields():void
		{
			var textWidth:Number = this.width / 5;
			var blackCaption:TextField = new TextField(textWidth, height, "BLACK", "LilyUPC", 30, 0x000000);
			var whiteCaption:TextField = new TextField(textWidth, height, "WHITE", "LilyUPC", 30, 0xFFFFFF);
			_blackScore = new TextField(textWidth, height, "0", "LilyUPC", 40, 0xFFFFFF, true);
			_whiteScore = new TextField(textWidth, height, "0", "LilyUPC", 40, 0xFFFFFF, true);
			whiteCaption.x = width - whiteCaption.width;
			_blackScore.x = (width >> 1) - _blackScore.width;
			_whiteScore.x = width >> 1;

			addChild(blackCaption);
			addChild(whiteCaption);
			addChild(_blackScore);
			addChild(_whiteScore);
		}

		private function initStones():void
		{
			_blackStone = new Image(AssetsManager.getTextureByName("blackStone"));
			_whiteStone = new Image(AssetsManager.getTextureByName("whiteStone"));
			_blackStone.x = _blackScore.x - _blackStone.width;
			_whiteStone.x = _whiteScore.x + _whiteScore.width;
			_blackStone.y = _whiteStone.y = height - _blackStone.height >> 1;
			addChild(_blackStone);
			addChild(_whiteStone);
		}

		public function setScore(score:uint, color:uint, currentPlayer:uint):void
		{
			if(color == PlayerHelper.BLACK)
			{
				_blackScore.text = score.toString();
			}
			else if(color == PlayerHelper.WHITE)
			{
				_whiteScore.text = score.toString();
			}

			_blackStone.alpha = currentPlayer == PlayerHelper.BLACK ? 1 : 0;
			_whiteStone.alpha = _blackStone.alpha == 1 ? 0 : 1;
		}
	}
}
