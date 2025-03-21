package com.lachhh.flash {
	import com.giveawaytool.MainGameTools;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.events.Event;

	/**
	 * @author LachhhSSD
	 */
	public class LogicLostFocus extends ActorComponent {
		public function LogicLostFocus() {
			super();
		}

		override public function start() : void {
			super.start();
			MainGameTools.instance.addEventListener(Event.DEACTIVATE, onDeactivate);
		}

		private function onDeactivate(event : Event) : void {
			new UILostFocus();
		}
		
		
		override public function destroy() : void {
			super.destroy();
			MainGameTools.instance.removeEventListener(Event.DEACTIVATE, onDeactivate);
		}
		
		static public function addToActor(actor:Actor):LogicLostFocus {
			var result:LogicLostFocus = new LogicLostFocus();
			actor.addComponent(result);
			return result;
		}
	}
}
