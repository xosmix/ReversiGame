/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import flash.geom.Point;

	import models.ICellModel;

	import starling.display.Image;
	import starling.textures.Texture;

	public class Cell extends Image
	{
		private var _model:ICellModel;
		public function Cell(model:ICellModel, texture:Texture):void
		{
			super(texture);
			_model = model;
			alpha = 0;
		}

		public function updateTexture(texture:Texture):void
		{
			this.texture = texture;
			alpha = 1;
		}

		private function showIfSelected(status:Boolean):void
		{
			alpha = status ? 1 : 0;
		}

		public function get position():Point
		{
			return _model.position;
		}
	}
}
