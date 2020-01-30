package
{
import control.InputController;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import utils.IState;
import utils.MyEvent;

import view.PlayerView;
import view.Scene;
import view.Menu;

public class Main extends Sprite
{
    public var scene:Scene;
    public var player1:PlayerView;
    public var player2:PlayerView;

    public function Main()
    {
        this.stage.scaleMode = StageScaleMode.NO_SCALE;
        this.stage.align = StageAlign.TOP_LEFT;
        this.loaderInfo.addEventListener(Event.COMPLETE, this.loaderInfo_completeHandler);
    }
    protected function loaderInfo_completeHandler(e:Event):void
    {
        this.scene = new Scene();
        this.addChild(scene);

    this.changeStateTo(Menu);
    this._inputControl = new InputController();
    this.addEventListener(Event.ENTER_FRAME, enterFrame_eventHandler);
    }

    
    private var _currentState:IState;

    [Embed(source="font/ARLRDBD.TTF",
            fontName="Arial Rounded MT Bold",
            mimeType="application/x-font",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var _arialRoundedFont:Class;
    private var _inputControl:InputController;

    private function enterFrame_eventHandler(event:Event):void {
        // AIRControl.update();
        if (_currentState) {
            _currentState.update();
        }
    }

    public function changeStateTo(state:Class):void {
        if (_currentState) {
            _currentState.destroy();
            removeChild(_currentState as Sprite);
            Sprite(_currentState).removeEventListener(MyEvent.REQUEST_STATE, onRequestState);
            _currentState = null;
        }
        _currentState = new state(_inputControl);
        Sprite(_currentState).addEventListener(MyEvent.REQUEST_STATE, onRequestState);
        addChild(_currentState as Sprite);
    }

    private function onRequestState(event:MyEvent):void {
        changeStateTo(event.data.state);
    }
}
}