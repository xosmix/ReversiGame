/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package event
{
	import starling.events.Event;

	public class BoardEvent extends Event
	{
		public static const CELL_CHANGED:String = "cellChanged";
		public static const BOARD_TEXTURE_CHANGED:String = "boardTextureChanged";
		private var _data:Object;
		public function BoardEvent(type:String, data:Object)
		{
			super(type);
			_data = data;
		}

		override public function get data():Object
		{
			return _data;
		}
	}
}
