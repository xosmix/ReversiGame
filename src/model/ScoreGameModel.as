/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package model
{
	import event.BoardEvent;

	import model.IBoardModel;

	public class ScoreGameModel implements IScoreGameModel
	{
		private var _player:uint;
		private var _score:uint = 2;
		private var _model:BoardModel;
		public function ScoreGameModel(model:BoardModel, player:uint):void
		{
			_model = model;
			_player = player;
		}

		public function get player():uint
		{
			return _player;
		}

		public function get score():uint
		{
			return _score;
		}

		public function set score(value:uint):void
		{
			_score = value;
			_model.dispatchEvent(new BoardEvent(BoardEvent.SCORE_CHANGED, {score: score, color: _player}))
		}

		public function reset():void
		{
			score = 0;
		}
	}
}
