/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package views
{
	import starling.events.Event;

	public class BoardView extends ComponentView
	{
		private var _children:Array;
		public function BoardView(model:Object, controller:Object = null)
		{
			_children = [];
		}

		override public function add(view:ComponentView):void
		{
			_children.push(view);
			addChild(view);
		}

		override public function update(e:* = null):void
		{
			for each(var child:ComponentView in _children)
			{
				child.update(e)
			}
		}
	}
}
