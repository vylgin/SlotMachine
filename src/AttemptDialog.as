package {
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

public class AttemptDialog extends Sprite {
    private var rec:Rectangle;
    private var attemptWidget:AttemptWidget;
    private var exitButton:SimpleButton;
    private var yesButton:SimpleButton;
    private var noButton:SimpleButton;

    public function AttemptDialog(rec:Rectangle, attemptWidget:AttemptWidget) {
        this.rec = rec;
        this.attemptWidget = attemptWidget;

        attemptWidget.hideForAttemptDialog();

        initMainRec();
        initExitButton();
        initMainText();
        initYesButton();
        initNoButton();
    }

    private function initMainRec():void {
        var box:Shape = new Shape();
        with (box.graphics) {
            lineStyle(1);
            beginFill(0xCCCCCC);
            drawRect(rec.x, rec.y + 120, rec.width, 70);
            endFill();
        }
        addChild(box);
    }

    private function initMainText():void {
        var textFormat:TextFormat = new TextFormat();
        textFormat.align = "center";

        var text:TextField = new TextField();
        text.text = "Вы собираетесь добавить 5 попыток.\nПродолжить?";
        text.x = rec.x + 100;
        text.y = rec.y + 135;
        text.width = 200;
        text.setTextFormat(textFormat);
        text.mouseEnabled = false;
        addChild(text);
    }

    private function initYesButton():void {
        yesButton = new SimpleButton();
        yesButton.x = rec.x /4 + 80;
        yesButton.y = rec.y /4 + 64;

        yesButton.upState = paintYesButton(0x42aaff);
        yesButton.overState = paintYesButton(0x7fc7ff);
        yesButton.downState = paintYesButton(0xafeeee);
        yesButton.hitTestState = yesButton.upState;

        yesButton.addEventListener(MouseEvent.CLICK, yesClickHandler);

        addChild(yesButton);
    }

    private function paintYesButton(color:Number):Sprite {
        var button:Sprite = new Sprite();
        button.x = yesButton.x;
        button.y = yesButton.y;

        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(yesButton.x, yesButton.y, 80, 20);
            endFill();
        }

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = "center";

        var textField:TextField = new TextField();
        textField.text = "Да";
        textField.x = yesButton.x;
        textField.y = yesButton.y;
        textField.width = 80;
        textField.height = 20;
        textField.mouseEnabled = false;
        textField.setTextFormat(textFormat);

        button.addChild(textField);

        return button;
    }

    private function initNoButton():void {
        yesButton = new SimpleButton();
        yesButton.x = rec.x /4 + 40;
        yesButton.y = rec.y /4 + 64;

        yesButton.upState = paintNoButton(0xff0000);
        yesButton.overState = paintNoButton(0xff8c69);
        yesButton.downState = paintNoButton(0xf36223);
        yesButton.hitTestState = yesButton.upState;

        yesButton.addEventListener(MouseEvent.CLICK, exitClickHandler);

        addChild(yesButton);
    }

    private function paintNoButton(color:Number):Sprite {
        var button:Sprite = new Sprite();
        button.x = yesButton.x;
        button.y = yesButton.y;

        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(yesButton.x, yesButton.y, 80, 20);
            endFill();
        }

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = "center";

        var textField:TextField = new TextField();
        textField.text = "Нет";
        textField.x = yesButton.x;
        textField.y = yesButton.y;
        textField.width = 80;
        textField.height = 20;
        textField.mouseEnabled = false;
        textField.setTextFormat(textFormat);

        button.addChild(textField);

        return button;
    }

    private function initExitButton():void {
        exitButton = new SimpleButton();
        exitButton.x = rec.x / 4 - 10;
        exitButton.y = rec.y / 4 - 10;

        exitButton.upState = paintExitButton(10);
        exitButton.overState = paintExitButton(11);
        exitButton.downState = paintExitButton(12);
        exitButton.hitTestState = exitButton.upState;

        exitButton.addEventListener(MouseEvent.CLICK, exitClickHandler);

        addChild(exitButton);
    }

    private function paintExitButton(r:Number):Shape {
        var button:Shape = new Shape();
        var circleX = rec.x + rec.width;
        var circleY = rec.y + 120;
        with (button.graphics) {
            lineStyle(2, 0x000000);
            beginFill(0xFF0000);
            drawCircle(circleX, circleY, r);
            moveTo(circleX - 5, circleY - 5);
            lineTo(circleX + 5, circleY + 5);
            moveTo(circleX + 5, circleY - 5);
            lineTo(circleX - 5, circleY + 5);
            endFill();
        }
        return button;
    }

    private function yesClickHandler(event:MouseEvent):void {
        attemptWidget.setAttempt(attemptWidget.getAttempt() + 5);
        closeAttemptDialog();
    }

    private function exitClickHandler(event:MouseEvent):void {
         closeAttemptDialog();
    }

    private function closeAttemptDialog():void {
        attemptWidget.showAfterAttemptDialog();
        while (this.numChildren > 0) {
            this.removeChildAt(0);
        }
    }
}
}
