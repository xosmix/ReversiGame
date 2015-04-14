/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.model
{

	import flash.geom.Point;

	import reversi.common.PlayerHelper;
	import reversi.event.BoardEvent;

	import starling.events.EventDispatcher;

	public class BoardModel extends EventDispatcher implements IBoardModel
	{
		public static const SIZE_BOARD:uint = 8;
		private var _board:Array;
		private var _blackScore:PlayerModel;
		private var _whiteScore:PlayerModel;
		private var _currentColor:uint;

		public function BoardModel()
		{
			_board = [];
			initCells();
			initPlayerScores();
		}

		private function initPlayerScores():void
		{
			_blackScore = new PlayerModel(this, PlayerHelper.BLACK);
			_whiteScore = new PlayerModel(this, PlayerHelper.WHITE);
		}

		private function initCells():void
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

		public function reset():void
		{
			for(var i:uint = 0; i < SIZE_BOARD; i++)
			{
				for(var j:uint = 0; j < SIZE_BOARD; j++)
				{
					var cell:ICellModel = _board[i][j];
					cell.reset();
					changeCell(cell.position, cell.owner);
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

			changeCell(blackStartPosition[0], PlayerHelper.BLACK);
			changeCell(blackStartPosition[1], PlayerHelper.BLACK);
			changeCell(whiteStartPosition[0], PlayerHelper.WHITE);
			changeCell(whiteStartPosition[1], PlayerHelper.WHITE);

			_currentColor = PlayerHelper.BLACK;
		}

		public function changeCell(position:Point, futureOwner:uint):void
		{
			var cellModel:ICellModel = _board[position.x][position.y];
			cellModel.owner = futureOwner;
			dispatchEvent(new BoardEvent(BoardEvent.CELL_CHANGED, {position: position}));
		}

		public function selectedCell(position:Point, status:Boolean):void
		{
			dispatchEvent(new BoardEvent(BoardEvent.CELL_SELECTED, {position: position, status: status}));
		}

		public function onGameOver(gameOverType:uint):void
		{
			dispatchEvent(new BoardEvent(BoardEvent.GAME_OVER, {type:gameOverType}));
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
			_currentColor = _currentColor == _blackScore.color ? _whiteScore.color : _blackScore.color;
			trace("current color is:  " + _currentColor);
		}

		public function get board():Array
		{
			return _board;
		}

		public function get blackPlayer():PlayerModel
		{
			return _blackScore;
		}

		public function get whitePlayer():PlayerModel
		{
			return _whiteScore;
		}

		public function get currentColor():uint
		{
			return _currentColor;
		}
	}
}
