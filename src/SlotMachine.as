package {

import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

public class SlotMachine extends Sprite {
    private var gameWindow:GameWindow;
    private var mainButton:SimpleButton;
    private static var attempt:uint;
    private static var rareMineral:uint;

    public function SlotMachine() {
        setAttempt(3);
        setRareMiniral(0);
        createMainButton();
        addChild(mainButton);
        mainButton.addEventListener(MouseEvent.CLICK, clickMainButton)
    }

    public static function setRareMiniral(count:uint):void {
        rareMineral = count;
    }

    public static function getRarelMiniral():uint {
        return rareMineral;
    }

    public static function setAttempt(i:uint):void {
        attempt = i;
    }

    public static function getAttempt():uint {
        return attempt;
    }

    private function createMainButton():void {
        mainButton = new SimpleButton();
        mainButton.x = stage.stageWidth / 4;
        mainButton.y = stage.stageHeight / 4;

        mainButton.upState = paintMainButton(25);
        mainButton.overState = paintMainButton(30);
        mainButton.downState = paintMainButton(35);
        mainButton.hitTestState = mainButton.upState;
    }

    private function paintMainButton(r:Number):Sprite {
        var circle:Sprite = new Sprite();
        with (circle.graphics) {
            beginFill(0xFF0000, 1)
            drawCircle(mainButton.x, mainButton.y, r);
            endFill();
        }

        var textFormat:TextFormat = new TextFormat();
        textFormat.color = 0xFFFFFF;
        textFormat.size = 16;

        var textField:TextField = new TextField();
        textField.text = "Go!";
        textField.x = mainButton.x - 13;
        textField.y = mainButton.y - 13;
        textField.mouseEnabled = false;
        textField.setTextFormat(textFormat);

        circle.addChild(textField);

        return circle
    }

    private function clickMainButton(event:MouseEvent):void {
        var w = 400;
        var h = 300;
        var rec:Rectangle = new Rectangle((stage.stageWidth - w) / 2, (stage.stageHeight - h) / 2, w, h);
        gameWindow = new GameWindow(rec);
        addChild(gameWindow);
    }
}
}
