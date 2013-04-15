package cn.royan.hl.uis.normal.bases;

import cn.royan.hl.geom.Position;
import cn.royan.hl.interfaces.uis.IUiTextBase;
import cn.royan.hl.uis.normal.InteractiveUiN;

import flash.text.TextFieldType;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.TextFieldAutoSize;

class UiNText extends InteractiveUiN, implements IUiTextBase
{
	static public inline var TEXT_ALIGN_LEFT:Int 	= 0;
	static public inline var TEXT_ALIGN_CENTER:Int 	= 1;
	static public inline var TEXT_ALIGN_RIGHT:Int	= 2;
	
	static public inline var TEXT_AUTOSIZE_NONE:Int = 0;
	static public inline var TEXT_AUTOSIZE_LEFT:Int = 1;
	static public inline var TEXT_AUTOSIZE_CENTER:Int = 2;
	static public inline var TEXT_AUTOSIZE_RIGHT:Int = 3;
	
	static public inline var TEXT_TYPE_INPUT:Int = 0;
	static public inline var TEXT_TYPE_PASSWORD:Int = 1;
	
	var inputText:TextField;
	
	public function new(label:String="") 
	{
		super();
		
		inputText = new TextField();
		inputText.text = label;
		inputText.mouseEnabled 	= false;
		inputText.selectable	= false;
		addChild( inputText );
	}
	
	override public function setSize(w:Int, h:Int):Void 
	{
		super.setSize(w, h);
		inputText.width = w;
		inputText.height = h;
	}
	
	public function setType(type:Int):Void
	{
		switch( type ) {
			case TEXT_TYPE_INPUT:
				inputText.type = TextFieldType.INPUT;
			case TEXT_TYPE_PASSWORD:
				inputText.type = TextFieldType.INPUT;
				inputText.displayAsPassword = true;
		}
	}
	
	public function autoSize(value:Int):Void
	{
		switch( value ) {
			case TEXT_AUTOSIZE_NONE:
				inputText.autoSize = TextFieldAutoSize.NONE;
			case TEXT_AUTOSIZE_LEFT:
				inputText.autoSize = TextFieldAutoSize.LEFT;
			case TEXT_AUTOSIZE_CENTER:
				inputText.autoSize = TextFieldAutoSize.CENTER;
			case TEXT_AUTOSIZE_RIGHT:
				inputText.autoSize = TextFieldAutoSize.RIGHT;
		}
		
		setSize(Std.int(inputText.textWidth), Std.int(inputText.textHeight));
	}
	
	public function setText(value:String):Void
	{
		inputText.text = value;
	}
	
	public function appendText(value:String):Void
	{
		inputText.appendText(value);
	}
	
	public function getText():String
	{
		return inputText.text;
	}
	
	public function setHTMLText(value:String):Void
	{
		inputText.htmlText = value;
	}
	
	public function appendHTMLText(value:String):Void
	{
		inputText.htmlText += value;
	}
	
	public function getHTMLText():String
	{
		return inputText.htmlText;
	}
	
	public function setTextAlign(value:Int):Void
	{
		var format:TextFormat = inputText.getTextFormat();
			format.align = switch(value) {
				case TEXT_ALIGN_CENTER:
					TextFormatAlign.CENTER;
				case TEXT_ALIGN_RIGHT:
					TextFormatAlign.RIGHT;
				default:
					TextFormatAlign.LEFT;
			}
		inputText.defaultTextFormat = format;
	}
	
	public function setTextColor(value:Int):Void
	{
		inputText.textColor = value;
	}
	
	public function setTextSize(value:Int):Void
	{
		var format:TextFormat = getFormat();
			format.size = value;
		inputText.defaultTextFormat = format;
	}
	
	public function setEmbedFont(value:Bool):Void
	{
		inputText.embedFonts = value;
	}
	
	public function setFormat(value:TextFormat, begin:Int=-1, end:Int=-1):Void
	{
		inputText.setTextFormat(value,begin,end);
	}
	
	public function getFormat(begin:Int=-1, end:Int=-1):TextFormat
	{
		return inputText.getTextFormat(begin, end);
	}
	
	public function setDefaultFormat(value:TextFormat):Void
	{
		inputText.defaultTextFormat = value;
	}
	
	public function getDefaultFormat():TextFormat
	{
		return inputText.defaultTextFormat;
	}
	#if flash
	public function setScroll(sx:Int = 0, sy:Int = 0):Void
	{
		inputText.scrollH = sx;
		inputText.scrollV = sy;
	}
	
	public function getScroll():Position
	{
		return { x:inputText.scrollH, y:inputText.scrollV };
	}
	
	public function getMaxScroll():Position
	{
		return { x:inputText.maxScrollH, y:inputText.maxScrollV };
	}
	#end
	public function setMultiLine(value:Bool):Void
	{
		inputText.multiline = value;
	}
}