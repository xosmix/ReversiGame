/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package reversi.common
{
	public class PlayerHelper
	{
		public static const BLACK:uint = 1;
		public static const WHITE:uint = 2;
		public static const EMPTY:uint = 0;

		public static const HUMAN:Boolean = true;
		public static const ROBOT:Boolean = false;

		public static function getNameTextureByPlayer(player:uint):String
		{
			switch(player)
			{
				case BLACK:
					return TextureHelper.BLACK_STONE;
				case WHITE:
					return TextureHelper.WHITE_STONE;
				default:
					return TextureHelper.EMPTY_CELL;
			}
		}
	}
}
