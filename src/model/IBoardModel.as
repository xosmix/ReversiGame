/**
 * Created by SergeyMalenko on 12.04.2015.
 */
package model
{
	import flash.geom.Point;

	public interface IBoardModel
	{
		function initStartPosition():void

		function changeCell(position:Point, futureOwner:uint):void

		function selectedCell(position:Point, status:Boolean):void

		function reset():void

		function getCellOwner(point:Point):uint;

		function setCellOwner(point:Point, owner:uint):void

		function changePlayer():void

		function get board():Array

		function get blackScore():ScoreGameModel;

		function get whiteScore():ScoreGameModel;

		function get currentPlayer():uint

		function set currentPlayer(value:uint):void
	}
}
