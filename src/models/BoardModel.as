/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import starling.display.Image;
	import starling.events.EventDispatcher;

	public class BoardModel extends EventDispatcher implements IBoardModel
	{
		private var _gameField:Vector.<ICell>;
		public function BoardModel()
		{
			_gameField =  new <ICell>[];
		}

		public function changeCell(cell:ICell):void
		{

		}

		public function getCellState(cell:ICell):Boolean
		{

		}

		public function reset():void
		{
			for each(var cell:ICell in _gameField)
			{
				cell.reset();
			}
		}

		public function setColor(image:Image):void
		{

		}
	}
}
