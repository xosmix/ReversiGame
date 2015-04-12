/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import flash.geom.Point;
	import starling.textures.Texture;

	public interface ICellModel
	{
		function get texture():Texture

		function set texture(value:Texture):void

		function get owner():IPlayer

		function set owner(value:IPlayer):void

		function get position():Point

		function set position(value:Point):void

		function reset():void
	}
}
