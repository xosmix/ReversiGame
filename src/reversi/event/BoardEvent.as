/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.event
{
	import starling.events.Event;

	public class BoardEvent extends Event
	{
		public static const CELL_CHANGED:String = "cellChanged";
		public static const SCORE_CHANGED:String = "scoreChanged";
		public static const CELL_SELECTED:String = "cellSelected";
		public static const GAME_OVER:String = "gameOver";

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
