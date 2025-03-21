package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberDynamic extends ViewSubscriberBtn {
		private var flashAnim:FlashAnimationView;

		public function ViewSubscriberDynamic(pScreen : UIBase, pVisual : DisplayObjectContainer) {
			flashAnim = new FlashAnimationView(pVisual);
			flashAnim.setAnim(AnimationFactory.ID_FX_SUBSCRIBER);
			super(pScreen, btn);
		}

		override public function destroy() : void {
			super.destroy();
			flashAnim.destroy();
		}

		public function get btn() : MovieClip {
			return flashAnim.anim.getChildByName("btn") as MovieClip;
		}
	}
}
