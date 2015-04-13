/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package model
{

	import event.BoardEvent;

	import flash.geom.Point;

	import starling.events.EventDispatcher;

	public class BoardModel extends EventDispatcher implements IBoardModel
	{
		public static const SIZE_BOARD:uint = 8;
		private var _board:Array;
		private var _blackScore:ScoreGameModel;
		private var _whiteScore:ScoreGameModel;
		private var _currentPlayer:uint;

		public function BoardModel()
		{
			_board = [];
			initPlayerScores();
		}

		private function initPlayerScores():void
		{
			_blackScore = new ScoreGameModel(this, PlayerFactory.BLACK);
			_whiteScore = new ScoreGameModel(this, PlayerFactory.WHITE);
		}

		public function reset():void
		{
			for(var i:uint = 0; i < SIZE_BOARD; i++)
			{
				_board[i] = [];
				for(var j:uint = 0; j < SIZE_BOARD; j++)
				{
					var cellModel:ICellModel = new CellModel(new Point(i, j));
					_board[i][j] = cellModel;
				}
			}
			_blackScore.reset();
			_whiteScore.reset();
		}

		public function initStartPosition():void
		{
			var posAverage:uint = _board.length / 2;
			var blackStartPosition:Vector.<Point> = new <Point>[new Point(posAverage - 1, posAverage),
				new Point(posAverage, posAverage - 1)];
			var whiteStartPosition:Vector.<Point> =	new <Point>[new Point(posAverage - 1, posAverage - 1),
						new Point(posAverage, posAverage)];

			changeCell(blackStartPosition[0], PlayerFactory.BLACK);
			changeCell(blackStartPosition[1], PlayerFactory.BLACK);
			changeCell(whiteStartPosition[0], PlayerFactory.WHITE);
			changeCell(whiteStartPosition[1], PlayerFactory.WHITE);
		}

		public function changeCell(position:Point, futureOwner:uint):void
		{
			var cellModel:ICellModel = _board[position.x][position.y];
			cellModel.owner = futureOwner;
			dispatchEvent(new BoardEvent(BoardEvent.CELL_CHANGED, {position: position}));
		}

		public function selectedCell(position:Point, status:Boolean):void
		{
			//dispatchEvent(new BoardEvent(BoardEvent.CELL_CHANGED, {position: position, status: status}));
		}

		public function getCellOwner(point:Point):uint
		{
			return _board[point.x][point.y].owner;
		}

		public function setCellOwner(point:Point, owner:uint):void
		{
			_board[point.x][point.y].owner = owner;
		}

		public function changePlayer():void
		{
			_currentPlayer = _currentPlayer == _blackScore.player ? _whiteScore.player : _blackScore.player;
			trace("current player is:  " + _currentPlayer);
		}

		public function get board():Array
		{
			return _board;
		}

		public function get blackScore():ScoreGameModel
		{
			return _blackScore;
		}

		public function get whiteScore():ScoreGameModel
		{
			return _whiteScore;
		}

		public function get currentPlayer():uint
		{
			return _currentPlayer;
		}

		public function set currentPlayer(value:uint):void
		{
			_currentPlayer = value;
		}
	}
}
