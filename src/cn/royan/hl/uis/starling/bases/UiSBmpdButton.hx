package cn.royan.hl.uis.starling.bases;

import cn.royan.hl.interfaces.uis.IUiItemGroupBase;
import cn.royan.hl.uis.starling.InteractiveUiS;
import cn.royan.hl.utils.BitmapDataUtils;
import cn.royan.hl.utils.SystemUtils;
import flash.geom.Rectangle;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import starling.display.Image;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.textures.Texture;

/**
 * ...
 * @author RoYan
 */

class UiSBmpdButton extends InteractiveUiS, implements IUiItemGroupBase
{
	var bgTextures:Array<Texture>;
	var currentStatus:Image;
	var isInGroup:Bool;
	var freshRect:Rectangle;
	
	public function new(texture:Array<Texture>)
	{
		super();
		
		bgTextures = [];
		
		setMouseRender(true);
		
		if( Std.is( texture, Array ) ){
			bgTextures = cast(texture);
			
		 	setSize(Std.int(bgTextures[0].width), Std.int(bgTextures[0].height));
			
			while ( bgTextures.length < 5 ) {
				bgTextures.push(bgTextures[bgTextures.length - 1]);
			}
		}else{
			//throw "texture is wrong type(Sparrow or Vector.<Sparrow>)";
			return;
		}
		
		currentStatus = new Image(Texture.fromBitmapData(BitmapDataUtils.fromColors(Std.int(containerWidth), Std.int(containerHeight), [0x00000], [0])));
		if ( bgTextures[status] != null ) {
			currentStatus.texture = bgTextures[status];
		}
		addChildAt(currentStatus, 0);
	}
	
	public function setInGroup(value:Bool):Void
	{
		isInGroup = value;
	}
	
	override function addToStageHandler(evt:Event=null):Void
	{
		super.addToStageHandler(evt);
	}
	
	override private function mouseOverHandler():Void 
	{
		super.mouseOverHandler();
		Mouse.cursor = MouseCursor.BUTTON;
	}
	
	override private function mouseOutHandler():Void 
	{
		super.mouseOutHandler();
		Mouse.cursor = MouseCursor.AUTO;
	}
	
	override function mouseClickHandler():Void
	{
		if( isInGroup ){
			selected = !selected;
			status = selected?InteractiveUiS.INTERACTIVE_STATUS_SELECTED:status;
			
			draw();
		}
		
		super.mouseClickHandler();
	}
	
	//Public methods
	override public function draw():Void
	{
		if ( !isOnStage ) return;
		if ( status < bgTextures.length && currentStatus != null ) {
			currentStatus.texture = bgTextures[status];
			currentStatus.scaleX = currentStatus.scaleY = getScale();
		}
	}
	
	override public function setColorsAndAplhas(color:Array<Dynamic>, alpha:Array<Dynamic>):Void 
	{
		bgColors = color;
		bgAlphas = alpha;
		
		while ( bgColors.length < InteractiveUiS.STATUS_LEN ) {
			bgColors.push( bgColors[bgColors.length - 1] );
		}
		
		while ( bgAlphas.length < InteractiveUiS.STATUS_LEN ) {
			bgAlphas.push( bgAlphas[bgAlphas.length - 1] );
		}
		
		for ( i in 0...bgColors.length ) {
			bgTextures[i] = Texture.fromBitmapData(BitmapDataUtils.fromColors(Std.int(containerWidth), Std.int(containerHeight), bgColors[i], bgAlphas[i]));
		}
		
		if ( currentStatus == null ) {
			currentStatus = new Image(Texture.fromBitmapData(BitmapDataUtils.fromColors(Std.int(containerWidth), Std.int(containerHeight), [0x00000], [0x00])));
			if( bgTextures[status] != null )
				currentStatus.texture = bgTextures[status];
			addChildAt(currentStatus, 0);
		}
		
		draw();
	}
	
	public function setSelected(value:Bool):Void
	{
		selected = value;
		status = selected?InteractiveUiS.INTERACTIVE_STATUS_SELECTED:InteractiveUiS.INTERACTIVE_STATUS_NORMAL;
		draw();
	}
	
	public function getSelected():Bool
	{
		return selected;
	}
	
	public function clone():UiSBmpdButton
	{
		return new UiSBmpdButton(bgTextures);
	}
	
	override public function setTexture(value:Texture, frames:Int=5):Void{}
	
	override public function dispose():Void
	{
		super.dispose();
		
		if( bgTextures != null )
			while ( bgTextures.length > 0 ) {
				bgTextures.pop().dispose();
			}
	}
}