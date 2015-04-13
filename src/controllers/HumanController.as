/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package controllers
{
	import flash.geom.Point;

	import models.BoardModel;
	import models.IBoardModel;
	import models.PlayerFactory;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import views.Cell;

	public class HumanController implements IHumanController
	{
		private var _model:IBoardModel;
		private var _turn:uint;

		public function HumanController(model:IBoardModel):void
		{
			_model = model;
		}

		public function onActivityCell(e:TouchEvent):void
		{
			var touchHover:Touch = e.getTouch(e.target as DisplayObject);
			if(touchHover == null)
			{
				_model.selectedCell((e.currentTarget as Cell).position, false);
				return;
			}

			if(touchHover.phase == TouchPhase.HOVER)
			{
				_model.selectedCell((e.currentTarget as Cell).position, true);
			}
			else if(touchHover.phase == TouchPhase.BEGAN)
			{
				makeMove((e.currentTarget as Cell).position);
			}
		}

		public function initStartPosition():void
		{
			_model.initStartPosition();
			_turn = PlayerFactory.BLACK_STONE;
		}

		private function makeMove(point:Point):void
		{
			if(!ifNextCellEmpty(point))
			{
				return;
			}
			if(findCaptures(point, true) == 0)
			{
				return;
			}
			placeStone(_turn, point);
			setCellOwner(point, _turn);
			//fTurnFinished();
			_turn = changeTurn(_turn);
		}

		private static function changeTurn(turn:uint):uint
		{
			return turn == PlayerFactory.BLACK_STONE ? PlayerFactory.WHITE_STONE : PlayerFactory.BLACK_STONE;
		}

		private function placeStone(turn:uint, position:Point):void
		{
			_model.changeCell(position, turn);
		}

		private function findCaptures(point:Point, turnStones:Boolean):uint
		{
			if(!ifNextCellEmpty(point))
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
			if(ifNextCellEmpty(newPoint))
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
			while(true)
			{
				++stoneCount;
				tempPoint.x += factor.x;
				tempPoint.y += factor.y;
				if(checkingBoundaries(tempPoint) || ifNextCellEmpty(tempPoint))
				{
					return 0;
				}
				if(checkNextSameOwner(tempPoint))
				{
					if(turnStones)
					{
						toLineStones(_turn, position, tempPoint, factor);
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

		private function ifNextCellEmpty(point:Point):Boolean
		{
			return getCellOwner(point) == PlayerFactory.EMPTY;
		}

		private function checkNextSameOwner(point:Point):Boolean
		{
			return getCellOwner(point) == _turn;
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

		private function fTurnFinished():void
		{

		}
	}
}
