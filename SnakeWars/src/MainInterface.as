package  
{

	import model.Model;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import view.View;
	
	public class MainInterface extends Sprite
	{
		private var modelInst:Model;
		private var viewInst:View;
		
		public function MainInterface() 
		{
			Starling.current.stage.stageWidth = 800;
			Starling.current.stage.stageHeight = 480;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Initiate model
			modelInst = Model.getInstance();
			
			// Initiate view
			viewInst = new View();
			viewInst.init();
			addChild(viewInst);
			viewInst.addEventListener(View.USERNAME_SELECTED, usernameSelectedHandler);
		}
		
		private function usernameSelectedHandler(e:Event)
		{
			trace("user name selected handler!!!!");
			modelInst.addEventListener(Model.CONNECT_AND_AUTH_OK, connectAndAuthOkHandler);
			modelInst.startNetworkInteraction(viewInst.desiredUsername);
		}
		
		
		private function connectAndAuthOkHandler(e:Event):void
		{
			viewInst.goToLobbyScreen();
			trace("connect");
		}
		
		
	}

}