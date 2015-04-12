/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import flash.errors.IllegalOperationError;

	import starling.display.DisplayObjectContainer;
	public class ComponentView extends DisplayObjectContainer
	{

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

		public function update(e:* = null):void
		{

		}


	}
}
