/**
 * Created by SergeyMalenko on 13.04.2015.
 */
package popup
{
	import starling.events.TouchEvent;

	public interface IPopup
	{
		function prepare(data:Object):void;

		function show(popup:String):void

		function onCloseHandler(e:TouchEvent):void;
	}
}
