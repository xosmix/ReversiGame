/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package reversi.model
{
	import reversi.event.BoardEvent;

	public class PlayerModel implements IPlayerModel
	{
		private var _color:uint;
		private var _score:uint = 0;
		private var _isMy:Boolean;
		private var _model:BoardModel;
		public function PlayerModel(model:BoardModel, player:uint):void
		{
			_model = model;
			_color = player;
		}

		public function get color():uint
		{
			return _color;
		}

		public function get score():uint
		{
			return _score;
		}

		public function set score(value:uint):void
		{
			_score = value;
			_model.dispatchEvent(new BoardEvent(BoardEvent.SCORE_CHANGED, {score: score, color: _color}))
		}

		public function reset():void
		{
			score = 0;
			isMy = false;
		}

		public function get isMy():Boolean
		{
			return _isMy;
		}

		public function set isMy(value:Boolean):void
		{
			_isMy = value;
		}
	}
}
