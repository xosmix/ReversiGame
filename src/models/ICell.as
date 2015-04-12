/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import flash.geom.Point;

	import starling.display.Image;

	public interface ICell
	{
		function get point():Point

		function set point(p:Point):void

		function reset():void

		function changeOwner(player:IPlayer = null):void

		function setColor(image:Image):void
	}
}
