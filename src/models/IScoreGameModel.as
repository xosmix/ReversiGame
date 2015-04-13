/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	public interface IScoreGameModel
	{
		function get player():uint

		function get score():uint

		function set score(value:uint):void

		function reset():void
	}
}
