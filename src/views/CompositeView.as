/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import starling.events.Event;

	public class CompositeView extends ComponentView
	{
		private var _children:Array;
		public function CompositeView(model:Object, controller:Object = null)
		{
			super(model, controller);
			_children = [];
		}

		override public function add(view:ComponentView):void
		{
			_children.push(view);
		}

		override public function update(e:Event = null):void
		{
			for each(var child:ComponentView in _children)
			{
				child.update(e)
			}
		}
	}
}
