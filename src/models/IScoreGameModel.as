/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package models
{
	public interface IScoreGameModel
	{
		function setScoreByPlayer(point:uint, player:IPlayer):void

		function getScoreByPlayer(player:IPlayer):uint

		function reset():void;
	}
}
