/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package controller
{
	import flash.geom.Point;

	import model.BoardModel;
	import model.GameOverHelper;
	import model.IBoardModel;
	import model.IPlayerModel;
	import model.PlayerHelper;

	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import view.CellView;

	public class HumanController implements IHumanController
	{
		private var _model:IBoardModel;
		private var _bot:BotController;

		public function HumanController(model:IBoardModel):void
		{
			_model = model;
		}

		private function initBot(player:IPlayerModel):void
		{
			_bot = new BotController(this, player.color);
		}

		private function autoTurn():void
		{
			if(_bot != null && _bot.color == _model.currentColor)
			{
				_bot.takeCell();
			}
		}

		public function initStartPosition():void
		{
			_model.initStartPosition();
			calculateScore();
		}

		public function reset():void
		{
			_model.reset();
			_bot = null;
			initStartPosition();
		}

		public function setConfigs(data:Object):void
		{
			if(data.rival == PlayerHelper.ROBOT)
			{
				if(data.color == PlayerHelper.BLACK)
				{
					initBot(_model.whitePlayer);
					_model.blackPlayer.isMy = true;
				}
				else if(data.color == PlayerHelper.WHITE)
				{
					initBot(_model.blackPlayer);
					_model.whitePlayer.isMy = true;
				}
			}
			else if(data.rival == PlayerHelper.HUMAN)
			{
				_model.blackPlayer.isMy = true;
				_model.whitePlayer.isMy = true;
				return;
			}

			autoTurn();
		}

		public function onActivityCell(e:TouchEvent):void
		{
			if(_model.currentColor == _model.blackPlayer.color && _model.blackPlayer.isMy ||
			   _model.currentColor == _model.whitePlayer.color && _model.whitePlayer.isMy)
			{
				var touchHover:Touch = e.getTouch(e.target as DisplayObject);
				if(touchHover == null)
				{
					if(cellIsEmpty((e.currentTarget as CellView).position))
					{
						_model.selectedCell((e.currentTarget as CellView).position, false);
					}
					return;
				}

				if(touchHover.phase == TouchPhase.HOVER)
				{
					if(cellIsEmpty((e.currentTarget as CellView).position))
					{
						_model.selectedCell((e.currentTarget as CellView).position, true);
					}
				}
				else if(touchHover.phase == TouchPhase.BEGAN)
				{
					takeCell((e.currentTarget as CellView).position);
				}
			}
		}

		public function takeCell(point:Point = null):void
		{
			if(_bot == null || _model.currentColor != _bot.color && !_bot.isRunnig)
			{
				makeMove(point);
			}
			else if(_model.currentColor == _bot.color && !_bot.isRunnig)
			{
				_bot.takeCell();
			}
		}

		internal function makeMove(point:Point):void
		{
			if(!cellIsEmpty(point))
			{
				return;
			}
			if(findCaptures(point, true) == 0)
			{
				return;
			}
			placeStone(_model.currentColor, point);
			setCellOwner(point, _model.currentColor);
			turnFinished(true);
		}

		private function placeStone(turn:uint, position:Point):void
		{
			_model.changeCell(position, turn);
		}

		internal function findCaptures(point:Point, turnStones:Boolean):uint
		{
			if(!cellIsEmpty(point))
			{
				return 0;
			}
			var topLeft:uint = findPath(point, new Point(-1, -1), turnStones);
			var top:uint = findPath(point, new Point(0, -1), turnStones);
			var topRight:uint = findPath(point, new Point(1, -1), turnStones);
			var right:uint = findPath(point, new Point(1, 0), turnStones);
			var bottomRight:uint = findPath(point, new Point(1, 1), turnStones);
			var bottom:uint = findPath(point, new Point(0, 1), turnStones);
			var bottomLeft:uint = findPath(point, new Point(-1, 1), turnStones);
			var left:uint = findPath(point, new Point(-1, 0), turnStones);
			return (topLeft + top + topRight + right + bottomRight + bottom + bottomLeft + left);
		}

		private function findPath(position:Point, factor:Point, turnStones:Boolean):uint
		{
			var newPoint:Point = new Point(position.x + factor.x, position.y + factor.y);
			if(checkingBoundaries(newPoint))
			{
				return 0;
			}
			if(cellIsEmpty(newPoint))
			{
				return 0;
			}
			if(checkNextSameOwner(newPoint))
			{
				return 0;
			}
			var countSameOwner:uint = findCellSameOwner(position, factor, turnStones);

			return countSameOwner;
		}

		private function findCellSameOwner(position:Point, factor:Point, turnStones:Boolean):uint
		{
			var tempPoint:Point = new Point(position.x, position.y);
			var stoneCount:uint = 0;
			var border:uint = BoardModel.SIZE_BOARD * BoardModel.SIZE_BOARD;
			while(stoneCount < border)
			{
				++stoneCount;
				tempPoint.x += factor.x;
				tempPoint.y += factor.y;
				if(checkingBoundaries(tempPoint) || cellIsEmpty(tempPoint))
				{
					return 0;
				}
				if(checkNextSameOwner(tempPoint))
				{
					if(turnStones)
					{
						toLineStones(_model.currentColor, position, tempPoint, factor);
					}
					return stoneCount - 1;
				}
			}

			return 0;
		}

		private function checkingBoundaries(point:Point):Boolean
		{
			var border:uint = BoardModel.SIZE_BOARD - 1;
			return point.x > border || point.x < 0 || point.y > border || point.y < 0;
		}

		internal function cellIsEmpty(point:Point):Boolean
		{
			return getCellOwner(point) == PlayerHelper.EMPTY;
		}

		internal function checkNextSameOwner(point:Point):Boolean
		{
			return getCellOwner(point) == _model.currentColor;
		}

		private function toLineStones(turn:uint, posFrom:Point, posTo:Point, factor:Point):void
		{
			var next:Point = new Point(posFrom.x, posFrom.y);
			var stonesToTurn:Array = [];
			while(true)
			{
				next.x += factor.x;
				next.y += factor.y;
				setCellOwner(next, turn);
				if(posTo.x != next.x || posTo.y != next.y)
				{
					stonesToTurn.push({turn: turn, x: next.x, y: next.y});
				}

				if(next.x == posTo.x && next.y == posTo.y)
				{
					changeOwners(stonesToTurn);
					break;
				}
			}
		}

		private function getCellOwner(point:Point):uint
		{
			return _model.getCellOwner(point);
		}

		private function setCellOwner(point:Point, owner:uint):void
		{
			_model.setCellOwner(point, owner);
		}

		private function changeOwners(stonesToTurn:Array):void
		{
			for each (var stone:Object in stonesToTurn)
			{
				_model.changeCell(new Point(stone.x, stone.y), stone.turn);
			}
		}

		private function turnFinished(changeTurn:Boolean):void
		{
			if(changeTurn)
			{
				_model.changePlayer();
				if(_bot != null && _bot.isRunnig)
				{
					_bot.isRunnig = false;
				}
				autoTurn();
			}
			calculateScore();
			if(isNextMovePossible())
			{
				return;
			}

			if((_model.blackPlayer.score + _model.whitePlayer.score) == BoardModel.SIZE_BOARD * BoardModel.SIZE_BOARD)
			{
				if(_model.blackPlayer.score == _model.whitePlayer.score)
				{
					_model.onGameOver(GameOverHelper.DEAD_HIT);
					return;
				}
				_model.onGameOver(GameOverHelper.IS_WINNER);
				return;
			}

			if(_model.blackPlayer.score == 0 || _model.whitePlayer.score == 0)
			{
				_model.onGameOver(GameOverHelper.FORFEITED);
				return;
			}

			if(isNextMovePossible())
			{
				_model.onGameOver(GameOverHelper.FORFEITED);
				return;
			}

			if(changeTurn)
			{
				_model.changePlayer();
				autoTurn();
			}
		}

		private function calculateScore():void
		{
			var tempPoint:Point;
			var blackCount:uint = 0;
			var whiteCount:uint = 0;
			for(var i:uint = 0; i < BoardModel.SIZE_BOARD; ++i)
			{
				for(var j:uint = 0; j < BoardModel.SIZE_BOARD; ++j)
				{
					tempPoint = new Point(i, j);
					if(cellIsEmpty(tempPoint))
					{
						continue;
					}
					if(getCellOwner(tempPoint) == _model.blackPlayer.color)
					{
						blackCount++;
					}
					else if(getCellOwner(tempPoint) == _model.whitePlayer.color)
					{
						whiteCount++;
					}
				}
			}

			_model.blackPlayer.score = blackCount;
			_model.whitePlayer.score = whiteCount;
		}

		private function isNextMovePossible():Boolean
		{
			var tempPoint:Point;
			for(var i:uint = 0; i < BoardModel.SIZE_BOARD; i++)
			{
				for(var j:uint = 0; j < BoardModel.SIZE_BOARD; j++)
				{
					tempPoint = new Point(i, j);
					if(!cellIsEmpty(tempPoint))
					{
						continue;
					}
					if(findCaptures(tempPoint, false) > 0)
					{
						return true;
					}
				}
			}
			return false;
		}
	}
}
