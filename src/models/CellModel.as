/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	import flash.geom.Point;

	import starling.textures.Texture;

	public class CellModel implements ICellModel
	{
		private var _texture:Texture;
		private var _owner:IPlayer;
		private var _position:Point;
		public function CellModel()
		{
		}

		public function get texture():Texture
		{
			return _texture;
		}

		public function set texture(value:Texture):void
		{
			_texture = value;
		}

		public function get owner():IPlayer
		{
			return _owner;
		}

		public function set owner(value:IPlayer):void
		{
			_owner = value;
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
		}

		public function reset():void
		{
			_texture = null;
			_owner = null;
		}
	}
}
