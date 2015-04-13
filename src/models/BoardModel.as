/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
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
		private var _currentPlayerScore = IScoreGameModel;

		public function BoardModel()
		{
			_board = [];
			_blackScore = new ScoreGameModel(PlayerFactory.BLACK);
			_whiteScore = new ScoreGameModel(PlayerFactory.WHITE);
			_currentPlayerScore = _blackScore;
			reset();
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
	}
}
