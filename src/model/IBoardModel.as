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

		function onGameOver(gameOverType:uint):void

		function reset():void

		function getCellOwner(point:Point):uint;

		function setCellOwner(point:Point, owner:uint):void

		function changePlayer():void

		function get board():Array

		function get blackPlayer():PlayerModel;

		function get whitePlayer():PlayerModel;

		function get currentColor():uint
	}
}
