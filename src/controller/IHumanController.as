/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package controller
{

	import flash.geom.Point;

	import starling.events.TouchEvent;

	public interface IHumanController
	{
		function initStartPosition():void
		function onActivityCell(e:TouchEvent):void

		function takeCell(point:Point = null):void
	}
}
