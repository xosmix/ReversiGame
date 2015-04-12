/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import flash.errors.IllegalOperationError;

	import starling.display.Sprite;

	import starling.events.Event;

	public class ComponentView extends Sprite
	{
		protected var _model:Object;
		protected var _controller:Object;
		public function ComponentView(model:Object, controller:Object)
		{
			_model = model;
			_controller = controller;
		}

		public function add(view:ComponentView):void
		{
			throw new IllegalOperationError("add denied");
		}

		public function remove(view:ComponentView):void
		{
			throw new IllegalOperationError("remove denied");
		}

		public function getViewByIndex(index:uint):ComponentView
		{
			throw new IllegalOperationError("getViewByIndex denied");
			return null;
		}

		public function update(e:Event = null):void
		{

		}


	}
}
