/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package controllers
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Point;
	import flash.utils.Timer;

	import models.BoardModel;

	public class BotController
	{
		private static const TOP_LEFT_CORNER:Point = new Point(0, 0);
		private static const TOP_RIGHT_CORNER:Point = new Point(7, 0);
		private static const BOTTOM_RIGHT_CORNER:Point = new Point(7, 7);
		private static const BOTTOM_LEFT_CORNER:Point = new Point(0, 7);

		private static const TOP_LEFT_X:Point = new Point(1, 1);
		private static const TOP_RIGHT_X:Point = new Point(6, 1);
		private static const BOTTOM_RIGHT_X:Point = new Point(6, 6);
		private static const BOTTOM_LEFT_X:Point = new Point(1, 6);

		private static const TOP_TOP_LEFT:Point = new Point(1, 0);
		private static const TOP_BOTTOM_LEFT:Point = new Point(0, 1);
		private static const TOP_TOP_RIGHT:Point = new Point(6, 0);
		private static const TOP_BOTTOM_RIGHT:Point = new Point(7, 1);
		private static const BOTTOM_TOP_RIGHT:Point = new Point(7, 6);
		private static const BOTTOM_BOTTOM_RIGHT:Point = new Point(6, 7);
		private static const BOTTOM_TOP_LEFT:Point = new Point(0, 6);
		private static const BOTTOM_BOTTOM_LEFT:Point = new Point(1, 7);

		private static var _controller:HumanController;
		private static var _color:uint;
		private static var _timer:Timer;

		public function BotController(controller:HumanController, color:uint)
		{
			_controller = controller;
			_color = color;
			_timer = new Timer(2000);
		}

		public function takeCell():void
		{
			if(_controller.currentPlayer == _color)
			{
				var bootStart:Function = function ():void
				{
					_timer.stop();
					_timer.removeEventListener(TimerEvent.TIMER, bootStart);
					calculateMove();
				};
				_timer.addEventListener(TimerEvent.TIMER, bootStart);
				_timer.start();
			}
		}

		private static function findCaptures(point:Point, turnStones:Boolean):uint
		{
			return _controller.findCaptures(point, turnStones);
		}
		private static function makeMove(point:Point):void
		{
			_controller.makeMove(point);
		}
		private static function checkNextSameOwner(point:Point):Boolean
		{
			return _controller.checkNextSameOwner(point);
		}
		private static function ifNextCellEmpty(point:Point):Boolean
		{
			return _controller.cellIsEmpty(point);
		}

		private function calculateMove():void
		{
			if(findCaptures(TOP_LEFT_CORNER, false) > 0)
			{
				makeMove(TOP_LEFT_CORNER[0]);
				return;
			}
			if(findCaptures(TOP_RIGHT_CORNER, false) > 0)
			{
				makeMove(TOP_RIGHT_CORNER);
				return;
			}
			if(findCaptures(BOTTOM_RIGHT_CORNER, false) > 0)
			{
				makeMove(BOTTOM_RIGHT_CORNER);
				return;
			}
			if(findCaptures(BOTTOM_LEFT_CORNER, false) > 0)
			{
				makeMove(BOTTOM_LEFT_CORNER);
				return;
			}

			if(checkNextSameOwner(TOP_LEFT_CORNER))
			{
				if(findAdjacentMove(TOP_LEFT_CORNER, new Point(1, 0), 6))
				{
					return;
				}
				if(findAdjacentMove(TOP_LEFT_CORNER, new Point(0, 1), 6))
				{
					return;
				}
			}
			if(checkNextSameOwner(TOP_RIGHT_CORNER))
			{
				if(findAdjacentMove(TOP_RIGHT_CORNER, new Point(-1, 0), 6))
				{
					return;
				}
				if(findAdjacentMove(TOP_RIGHT_CORNER, new Point(0, 1), 6))
				{
					return;
				}
			}
			if(checkNextSameOwner(BOTTOM_RIGHT_CORNER))
			{
				if(findAdjacentMove(BOTTOM_RIGHT_CORNER, new Point(-1, 0), 6))
				{
					return;
				}
				if(findAdjacentMove(BOTTOM_RIGHT_CORNER, new Point(0, -1), 6))
				{
					return;
				}
			}
			if(checkNextSameOwner(BOTTOM_LEFT_CORNER))
			{
				if(findAdjacentMove(BOTTOM_LEFT_CORNER, new Point(1, 0), 6))
				{
					return;
				}
				if(findAdjacentMove(BOTTOM_LEFT_CORNER, new Point(0, -1), 6))
				{
					return;
				}
			}

			if(findAdjacentMove(TOP_TOP_LEFT, new Point(1, 0), 4))
			{
				return;
			}
			if(findAdjacentMove(TOP_BOTTOM_RIGHT, new Point(0, 1), 4))
			{
				return;
			}
			if(findAdjacentMove(BOTTOM_BOTTOM_RIGHT, new Point(-1, 0), 4))
			{
				return;
			}
			if(findAdjacentMove(BOTTOM_TOP_LEFT, new Point(0, -1), 4))
			{
				return;
			}

			var captureCounts:Array = [];
			var border:uint = BoardModel.SIZE_BOARD - 1;
			var tempPoint:Point;
			for(var i:uint = 0; i < border; ++i)
			{
				for(var j:uint = 0; j < border; ++j)
				{
					tempPoint = new Point(i, j);
					if(!ifNextCellEmpty(tempPoint))
					{
						continue;
					}
					if((tempPoint == TOP_LEFT_X) ||
					   (tempPoint == TOP_RIGHT_X) ||
					   (tempPoint == BOTTOM_LEFT_X) ||
					   (tempPoint == BOTTOM_RIGHT_X) ||
					   (tempPoint == TOP_TOP_LEFT) ||
					   (tempPoint == TOP_BOTTOM_LEFT) ||
					   (tempPoint == TOP_TOP_RIGHT) ||
					   (tempPoint == TOP_BOTTOM_RIGHT) ||
					   (tempPoint == BOTTOM_TOP_RIGHT) ||
					   (tempPoint == BOTTOM_BOTTOM_RIGHT) ||
					   (tempPoint == BOTTOM_TOP_LEFT) ||
					   (tempPoint == BOTTOM_BOTTOM_LEFT))
					{
						continue;
					}
					var captureCount:uint = findCaptures(tempPoint, false);
					if(captureCount == 0)
					{
						continue;
					}
					var captureData:Object = {};
					captureData.stones = captureCount;
					captureData.point = tempPoint;
					captureCounts.push(captureData);
				}
			}

			if(captureCounts.length > 0)
			{
				captureCounts.sortOn("stones", Array.NUMERIC, Array.DESCENDING);
				var bestMove:Object = captureCounts.pop();
				if(bestMove.stones > 0)
				{
					makeMove(bestMove.point);
					return;
				}
			}

			if(findCaptures(TOP_TOP_LEFT, false))
			{
				makeMove(TOP_TOP_LEFT);
				return;
			}
			if(findCaptures(TOP_BOTTOM_LEFT, false))
			{
				makeMove(TOP_BOTTOM_LEFT);
				return;
			}
			if(findCaptures(TOP_TOP_RIGHT, false))
			{
				makeMove(TOP_TOP_RIGHT);
				return;
			}
			if(findCaptures(TOP_BOTTOM_RIGHT, false))
			{
				makeMove(TOP_BOTTOM_RIGHT);
				return;
			}
			if(findCaptures(BOTTOM_TOP_RIGHT, false))
			{
				makeMove(BOTTOM_TOP_RIGHT);
				return;
			}
			if(findCaptures(BOTTOM_BOTTOM_RIGHT, false))
			{
				makeMove(BOTTOM_BOTTOM_RIGHT);
				return;
			}
			if(findCaptures(BOTTOM_TOP_LEFT, false))
			{
				makeMove(BOTTOM_TOP_LEFT);
				return;
			}
			if(findCaptures(BOTTOM_BOTTOM_LEFT, false))
			{
				makeMove(BOTTOM_BOTTOM_LEFT);
				return;
			}

			if(findCaptures(TOP_LEFT_X, false))
			{
				makeMove(TOP_LEFT_X);
				return;
			}
			if(findCaptures(TOP_RIGHT_X, false))
			{
				makeMove(TOP_RIGHT_X);
				return;
			}
			if(findCaptures(BOTTOM_LEFT_X, false))
			{
				makeMove(BOTTOM_LEFT_X);
				return;
			}
			if(findCaptures(BOTTOM_RIGHT_X, false))
			{
				makeMove(BOTTOM_RIGHT_X);
				return;
			}
		}

		private function findAdjacentMove(point:Point, factor:Point, depth:uint):Boolean
		{
			var tempPoint:Point = new Point(point.x, point.y);
			for(var i:uint = 0; i < depth; ++i)
			{
				tempPoint.x += factor.x;
				tempPoint.y += factor.y;
				if(checkNextSameOwner(tempPoint))
				{
					if(findCaptures(tempPoint, false) > 0)
					{
						makeMove(tempPoint);
						return true;
					}
				}
			}
			return false;
		}

		public function get color():uint
		{
			return _color;
		}
	}
}
