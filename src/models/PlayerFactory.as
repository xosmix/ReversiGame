/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package models
{
	public class PlayerFactory
	{


		public static const BLACK_STONE:uint = 1;
		public static const WHITE_STONE:uint = 2;
		public static const EMPTY:uint = 0;

		private static const BLACK_STONE_TEXTURE:String = "blackStone";
		private static const WHITE_STONE_TEXTURE:String = "whiteStone";
		private static const EMPTY_TEXTURE:String = "empty";

		public static function getNameTextureByPlayer(player:uint):String
		{
			switch(player)
			{
				case BLACK_STONE:
					return BLACK_STONE_TEXTURE;
				case WHITE_STONE:
					return WHITE_STONE_TEXTURE;
				default:
					return EMPTY_TEXTURE
			}
		}
	}
}
