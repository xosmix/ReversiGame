/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import flash.geom.Point;

	import starling.display.Image;

	public interface IBoardModel
	{
		function changeCell(cell:ICell):void

		function getCellState(cell:ICell):Boolean

		function reset():void

		function setColor(image:Image):void
	}
}
