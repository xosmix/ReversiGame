/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.model
{
	public interface IPlayerModel
	{
		function get color():uint

		function get score():uint

		function set score(value:uint):void

		function reset():void

		function get isMy():Boolean

		function set isMy(value:Boolean):void
	}
}
