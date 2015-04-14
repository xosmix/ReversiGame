/**
 * Created by SergeyMalenko on 14.04.2015.
 */
package reversi.error
{
	public class GameError extends Error
	{
		public static const TEXTURE_IS_NULL:String = "textureIsNull";
		public static const SINGLETON:String = "singleTon";
		public function GameError(message:* = "", id:* = 0)
		{
			super(message, id);
		}
	}
}
