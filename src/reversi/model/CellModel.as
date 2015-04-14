/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.model
{
	import flash.geom.Point;

	import reversi.common.PlayerHelper;

	public class CellModel implements ICellModel
	{
		private var _owner:uint = 0;
		private var _position:Point;
		public function CellModel(position:Point)
		{
			_position = position;
			reset();
		}
		public function get owner():uint
		{
			return _owner;
		}

		public function set owner(value:uint):void
		{
			_owner = value;
		}

		public function get position():Point
		{
			return _position;
		}

		public function reset():void
		{
			_owner = PlayerHelper.EMPTY;
		}
	}
}
