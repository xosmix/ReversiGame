/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package models
{
	public class ScoreGameModel implements IScoreGameModel
	{
		private var _player:uint;
		private var _score:uint = 2;
		public function ScoreGameModel(player:uint):void
		{
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
		}

		public function reset():void
		{
			_score = 0;
		}
	}
}
