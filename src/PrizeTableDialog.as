package {
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class PrizeTableDialog extends Sprite {
    private var gameWindow:GameWindow;
    private var rec:Rectangle;
    private var exitButton:SimpleButton;
    private var closeButton:SimpleButton;

    public function PrizeTableDialog(gameWindow:GameWindow, rec:Rectangle) {
        this.gameWindow = gameWindow;
        this.rec = rec;

        initMainRec();
        initHeaderWidget();
        initExitButton();
        initCloseButton();
        initPrizeBoxes();
    }

    private function initPrizeBoxes():void {
        var x:int = rec.x / 4 + 45;
        var y:int = rec.y / 4 + 60;
        var w:int = 190;
        var h:int = 40;

        var i;
        var j;
        for (i = 0, j = y; i < 5; i++, j+=45) {
            paintPrizeBox(x, j, w, h, i, 1);
        }

        for (i = 0, j = y; i < 5; i++, j+=45) {
            paintPrizeBox(x + w + 5, j, w, h, i, 2);
        }
    }

    private function paintPrizeBox(x:int, y:int, w:int, h:int, count:int, row:int):void {
        var textField:TextField = new TextField();
        textField.x = x;
        textField.y = y;
        textField.width = w;
        textField.height = h;
        textField.border = true;
        textField.background = true;
        textField.backgroundColor = 0xFFFFFF;

        switch (row) {
            case 1:
                if (count == 0) {
                    textField.text = " " + gameWindow.getSymbol().getSymbols()[count] +
                            " " + gameWindow.getSymbol().getSymbols()[count] + " " +
                            gameWindow.getSymbol().getSymbols()[count] +
                            " - 100 " +
                            gameWindow.getSymbol().getSymbols()[count];
                } else if (count == 4) {
                    textField.text = gameWindow.getSymbol().getSymbols()[count] +
                            " " + gameWindow.getSymbol().getSymbols()[count] + " " +
                            gameWindow.getSymbol().getSymbols()[count] +
                            " - Дополнительные попытки: 5";
                } else {
                    textField.text = gameWindow.getSymbol().getSymbols()[count] +
                            " " + gameWindow.getSymbol().getSymbols()[count] + " " +
                            gameWindow.getSymbol().getSymbols()[count] +
                            " - 3 редких материала";
                }
                break;
            case 2:
                if (count == 0) {
                    textField.text = gameWindow.getSymbol().getSymbols()[count] +
                            " " + gameWindow.getSymbol().getSymbols()[count] + " - 10 " +
                            gameWindow.getSymbol().getSymbols()[count];
                } else if(count == 4) {
                    textField.text = gameWindow.getSymbol().getSymbols()[count] + " " +
                            gameWindow.getSymbol().getSymbols()[count] +
                            " - Дополнительные попытки: 2";
                } else
                {
                    textField.text = gameWindow.getSymbol().getSymbols()[count] + " " +
                            gameWindow.getSymbol().getSymbols()[count] +
                            " - один редкий материал";
                }
                break;

        }
        addChild(textField);
    }

    private function initMainRec():void {
        var box:Shape = new Shape();
        with (box.graphics) {
            lineStyle(1);
            beginFill(0xCCCCCC);
            drawRect(rec.x, rec.y, rec.width, rec.height);
            endFill();
        }
        addChild(box);
    }

    private function initHeaderWidget():void {
        var headTextBox:Shape = new Shape();
        with (headTextBox.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(rec.x, rec.y, rec.width, 20);
            endFill();
        }

        var text:TextField = new TextField();
        text.text = "Таблица призов";
        text.x = rec.x;
        text.y = rec.y;

        addChild(headTextBox);
        addChild(text);
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
        var circleY = rec.y;
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

    private function initCloseButton():void {
        closeButton = new SimpleButton();
        closeButton.x = rec.x / 4 + 60;
        closeButton.y = rec.y / 4 + 95;

        closeButton.upState = paintCloseButton(0x42aaff);
        closeButton.overState = paintCloseButton(0x7fc7ff);
        closeButton.downState = paintCloseButton(0xafeeee);
        closeButton.hitTestState = closeButton.upState;

        closeButton.addEventListener(MouseEvent.CLICK, exitClickHandler);

        addChild(closeButton);
    }

    private function paintCloseButton(color:Number):Sprite {
        var x:int = closeButton.x;
        var y:int = closeButton.y;
        var w:int = 80;
        var h:int = 20;

        var button:Sprite = new Sprite();
        button.x = x;
        button.y = y;

        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(x, y, w, h);
            endFill();
        }

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = TextFormatAlign.CENTER;

        var textField:TextField = new TextField();
        textField.text = "Закрыть";
        textField.x = x;
        textField.y = y;
        textField.width = w;
        textField.height = h;
        textField.mouseEnabled = false;
        textField.setTextFormat(textFormat);

        button.addChild(textField);

        return button;
    }


    private function exitClickHandler(event:MouseEvent):void {
        while (this.numChildren > 0) {
            this.removeChildAt(0);
        }
    }
}
}
