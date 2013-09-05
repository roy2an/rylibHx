package cn.royan.hl.uis.graphs;

import cn.royan.hl.interfaces.uis.IUiGraphBase;
import cn.royan.hl.uis.sparrow.Sparrow;
import cn.royan.hl.uis.graphs.UiGStage;

import flash.geom.Rectangle;

/**
 * ...
 * @author RoYan
 */
class UiGBmpdShape implements IUiGraphBase
{
	var stage:UiGStage;
	var parent:IUiGraphBase;
	
	var bound:Rectangle;
	var containerWidth:Int;
	var containerHeight:Int;
	var positionX:Int;
	var positionY:Int;
	var scaleX:Float;
	var scaleY:Float;
	var rotation:Float;
	var alpha:Float;
	var visible:Bool;
	
	var texture:Sparrow;
	var updated:Bool;
	
	var excludes:Array<String>;
	var includes:Array<String>;
	
	public function new() 
	{
		bound 			= new Rectangle();
		containerWidth 	= 0;
		containerHeight = 0;
		positionX		= 0;
		positionY		= 0;
		scaleX			= 1;
		scaleY			= 1;
		rotation		= 0;
		alpha			= 1;
		visible			= true;
	}
	
	public function create(sparrow:Sparrow):Void
	{
		texture = sparrow;
		setSize(Std.int(texture.regin.width), Std.int(texture.regin.height));
	}
	
	/**
	 * 设置舞台
	 */
	public function setStage(value:UiGStage):Void
	{
		//stage = value;
	}
	
	/**
	 * 设置父容器
	 * @param	value
	 */
	public function setParent(value:IUiGraphBase):Void
	{
		parent = value;
	}
	
	/**
	 * 更新显示
	 */
	public function updateDisplayList(item:IUiGraphBase = null):Void
	{
		if ( parent != null )
			parent.updateDisplayList(this);
		updated = true;
	}
	
	public function isUpdate():Bool
	{
		return updated;
	}
	
	/**
	 * 画布刷新
	 */
	public function draw():Void
	{
		updated = false;
	}

	/**
	 * 设置尺寸
	 * @param	cWidth
	 * @param	cHeight
	 */
	public function setSize(cWidth:Int, cHeight:Int):Void
	{
		updateDisplayList();
		
		containerWidth 	= cWidth;
		containerHeight	= cHeight;
		
		bound.width 	= containerWidth;
		bound.height	= containerHeight;
	}
	
	/**
	 * 设置位置
	 * @param	cX
	 * @param	cY
	 */
	public function setPosition(cX:Int, cY:Int):Void
	{
		updateDisplayList();
		
		positionX = cX;
		positionY = cY;
		
		bound.x = positionX;
		bound.y	= positionY;
	}
	
	/**
	 * 获取感应范围
	 * @return
	 */
	public function getBound():Rectangle
	{
		return bound;
	}
	
	/**
	 * 获取当前材质
	 * @return
	 */
	public function getTexture():Sparrow
	{
		return texture;
	}
	
	/**
	 * 设置X缩放比例
	 * @param	value
	 */
	public function setScaleX(value:Float):Void
	{
		scaleX = value;
	}
	
	/**
	 * 获取X缩放比列
	 * @return
	 */
	public function getScaleX():Float
	{
		return scaleX;
	}
	
	/**
	 * 设置X缩放比例
	 * @param	value
	 */
	public function setScaleY(value:Float):Void
	{
		scaleY = value;
	}
	
	/**
	 * 获取X缩放比列
	 * @return
	 */
	public function getScaleY():Float
	{
		return scaleY;
	}
	
	/**
	 * 设置角度
	 * @param	value
	 */
	public function setRotation(value:Float):Void
	{
		rotation = value;
	}
	
	/**
	 * 获取角度
	 * @return
	 */
	public function getRotation():Float
	{
		return rotation;
	}
	
	/**
	 * 设置透明度
	 * @param	value
	 */
	public function setAlpha(value:Float):Void
	{
		alpha = value;
	}
	
	/**
	 * 获取透明度
	 * @return
	 */
	public function getAlpha():Float
	{
		return alpha;
	}
	
	/**
	 * 设置显示
	 * @param	value
	 */
	public function setVisible(value:Bool):Void
	{
		visible = value;
	}
	
	/**
	 * 过去显示
	 * @return
	 */
	public function getVisible():Bool
	{
		return visible;
	}
	
	/**
	 * 设置容器状态对应隐藏列表
	 * @param	args
	 */
	public function setExclude(args:Array<String>):Void
	{
		excludes = args;
	}
	
	/**
	 * 获取容器状态对应隐藏列表
	 * @return
	 */
	public function getExclude():Array<String>
	{
		return excludes;
	}
	
	/**
	 * 设置容器状态对应显示列表
	 * @param	args
	 */
	public function setInclude(args:Array<String>):Void
	{
		includes = args;
	}
	
	/**
	 * 获取容器状态对应显示列表
	 * @return
	 */
	public function getInclude():Array<String>
	{
		return includes;
	}
	
	/**
	 * 销毁
	 */
	public function dispose():Void
	{
		texture.dispose();
		texture = null;
	}
}