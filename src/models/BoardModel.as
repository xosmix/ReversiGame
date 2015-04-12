/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import core.GraphicsManager;

	import event.BoardEvent;

	import event.BoardEvent;

	import flash.geom.Point;

	import starling.display.Image;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;

	public class BoardModel extends EventDispatcher implements IBoardModel
	{
		private var _gameField:Array;
		private static const SIZE_BOARD:uint = 8;
		private var _texture:Texture;
		public function BoardModel()
		{
			initBoard();
			initCells();
		}

		private function initBoard():void
		{
			_texture = GraphicsManager.assets.getTexture("board");
			_gameField = [];
		}

		private function initCells():void
		{
			for(var i:uint = 0; i < SIZE_BOARD; i++)
			{
				_gameField[i] = [];
				for(var j:uint = 0; j < SIZE_BOARD; j++)
				{
					var cellModel:ICellModel = new CellModel();
					cellModel.position = new Point(i, j);
					cellModel.texture = GraphicsManager.assets.getTexture("empty");
					_gameField[i][j] = cellModel;
				}
			}
		}

		public function changeCell(cell:ICellModel):void
		{
			_gameField[cell.position.x][cell.position.y] = cell;
			dispatchEvent(new BoardEvent(BoardEvent.CELL_CHANGED, {position: cell.position}));
		}

		public function getCellState(cell:ICellModel):Boolean
		{
			return false;
		}

		public function reset():void
		{
			for each(var cell:ICellModel in _gameField)
			{
				cell.reset();
			}
		}

		public function get gameField():Array
		{
			return _gameField;
		}

		public function get texture():Texture
		{
			return _texture;
		}

		public function set texture(value:Texture):void
		{
			_texture = value;
		}
	}
}
