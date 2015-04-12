/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import flash.geom.Point;

	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.Texture;

	public interface IBoardModel
	{
		function changeCell(cell:ICellModel):void

		function getCellState(cell:ICellModel):Boolean

		function reset():void

		function get gameField():Array

		function set texture(value:Texture):void

		function get texture():Texture;
	}
}
