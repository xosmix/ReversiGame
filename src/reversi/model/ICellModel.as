/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package reversi.model
{
	import flash.geom.Point;

	public interface ICellModel
	{
		function get owner():uint

		function set owner(value:uint):void

		function get position():Point

		function reset():void
	}
}
