/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package controllers
{

	import starling.events.TouchEvent;

	public interface IHumanController
	{
		function initStartPosition():void
		function onActivityCell(e:TouchEvent):void
	}
}
