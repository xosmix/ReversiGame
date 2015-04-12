/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import flash.events.Event;

	import starling.display.Image;
	import starling.textures.Texture;

	public class Cell extends ComponentView
	{
		private var _texture:Texture;
		private var _image:Image;
		public function Cell(texture:Texture)
		{
			update(texture);
		}

		override public function update(texture:* = null):void
		{
			if(_texture != texture)
			{
				_texture = texture;
				if(_image != null)
				{
					removeChild(_image);
				}
				_image = new Image(_texture);
				addChild(_image);
			}
		}
	}
}
