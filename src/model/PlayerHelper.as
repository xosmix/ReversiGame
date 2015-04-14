/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package model
{
	public class PlayerHelper
	{
		public static const BLACK:uint = 1;
		public static const WHITE:uint = 2;
		public static const EMPTY:uint = 0;

		private static const BLACK_STONE_TEXTURE:String = "blackStone";
		private static const WHITE_STONE_TEXTURE:String = "whiteStone";
		private static const EMPTY_TEXTURE:String = "empty";

		public static const HUMAN:Boolean = true;
		public static const ROBOT:Boolean = false;

		public static function getNameTextureByPlayer(player:uint):String
		{
			switch(player)
			{
				case BLACK:
					return BLACK_STONE_TEXTURE;
				case WHITE:
					return WHITE_STONE_TEXTURE;
				default:
					return EMPTY_TEXTURE
			}
		}
	}
}
