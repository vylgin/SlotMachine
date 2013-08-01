package {
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

public class AttemptWidget extends Sprite {
    private var rec:Rectangle;
    private var attempt:uint;
    private var infoBox:Sprite;
    private var textFieldInfoBox:TextField;
    private var attemptButton:SimpleButton;
    private var gameWindow:GameWindow;

    public function AttemptWidget(attempt:uint, rec:Rectangle, gameWindow:GameWindow) {
        this.attempt = attempt;
        this.rec = rec;
        this.gameWindow = gameWindow;

        initInfoBox();
        initAttemptButton();
    }

    public function setAttempt(attempt:uint):void {
        this.attempt = attempt;
        updateTextInfoBox();
    }

    public function getAttempt():uint {
        return this.attempt;
    }

    public function hideForAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            if (getChildAt(i).name != "attemptDialog") {
                getChildAt(i).visible = false;
            }
        }
        gameWindow.hideForAttemptDialog();
    }

    public function showAfterAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            getChildAt(i).visible = true;
        }
        gameWindow.showAfterAttemptDialog();
    }

    private function initInfoBox():void {
        infoBox = new Sprite();
        infoBox.x = rec.x + 131;
        infoBox.y = rec.y + 90;

        textFieldInfoBox = new TextField();
        textFieldInfoBox.x = infoBox.x;
        textFieldInfoBox.y = infoBox.y;
        textFieldInfoBox.width = 80;
        textFieldInfoBox.height = 20;
        textFieldInfoBox.setTextFormat(getCenterTextFormat());

        var recInfoBox:Shape = new Shape();
        with (recInfoBox.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(infoBox.x, infoBox.y, 80, 20);
            endFill();
        }

        infoBox.addChild(recInfoBox);
        infoBox.addChild(textFieldInfoBox);
        updateTextInfoBox();
        addChild(infoBox);
    }

    private function updateTextInfoBox():void {
       textFieldInfoBox.text = "Попыток: " + attempt;
    }

    private function initAttemptButton():void {
        attemptButton = new SimpleButton();
        attemptButton.x = rec.x + 131;
        attemptButton.y = rec.y + 100;

        attemptButton.upState = paintAttemptButton(0xefd334);
        attemptButton.overState = paintAttemptButton(0xffff00);
        attemptButton.downState = paintAttemptButton(0xfde910);
        attemptButton.hitTestState = attemptButton.upState;

        attemptButton.addEventListener(MouseEvent.CLICK, attemptButtonClickHandler);

        addChild(attemptButton);
    }

    private function paintAttemptButton(color:Number):Sprite {
        var button:Sprite = new Sprite();
        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(attemptButton.x, attemptButton.y, 80, 20);
            endFill();
        }

        var textField:TextField = new TextField();
        textField.text = "Добавить";
        textField.x = attemptButton.x;
        textField.y = attemptButton.y;
        textField.mouseEnabled = false;

        button.addChild(textField);

        return button;
    }

    private function attemptButtonClickHandler(event:MouseEvent):void {
        var attemptDialog:AttemptDialog = new AttemptDialog(rec, this);
        attemptDialog.name = "attemptDialog";
        addChild(attemptDialog);
    }

    private function getCenterTextFormat():TextFormat {
        var textFormat:TextFormat = new TextFormat();
        textFormat.align = "center";
        return textFormat;
    }
}
}
