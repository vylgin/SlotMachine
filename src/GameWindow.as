package {
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

public class GameWindow extends Sprite{
    private var prizeTableButton:SimpleButton;
    private var exitButton:SimpleButton;
    private var rec:Rectangle;
    private var daysInGameWidget:DaysInGameWidget;
    private var attemptWidget:AttemptWidget;
    private var prizeWidget:PrizeWidget;
    private var spinWidget:SpinWidget;

    public function GameWindow(rec:Rectangle) {
        this.rec = rec;
        initGui();
    }

    public function hideForAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            if (getChildAt(i).name != "attempt") {
                getChildAt(i).visible = false;
            }
        }
    }

    public function showAfterAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            getChildAt(i).visible = true;
        }
    }

    private function initGui():void {
        initMainRec();
        initHeaderWidget();
        initExitButton();
        initDaysInGameWidget();
        initAttemptWidget();
        initPrizeTableButton();
        initPrizeWidget();
        initSpinWidget();
        initSpinButton();
    }

    private function initSpinButton():void {
        spinWidget = new SpinWidget(rec);

        addChild(spinWidget);
    }

    private function initSpinWidget():void {
        spinWidget = new SpinWidget(rec);

        addChild(spinWidget);
    }

    private function initPrizeWidget():void {
        prizeWidget = new PrizeWidget(rec);
//        prizeWidget.print("Воспользуйтесь кнопкой \"Таблица призов\",\nчтобы узнать доступные комбинации\nи призы.");
        prizeWidget.print("Нажмите на рычаг и испытайте\nсвою удачу!");

        addChild(prizeWidget);
    }

    private function initAttemptWidget():void {
        attemptWidget = new AttemptWidget(SlotMachine.getAttempt(), rec, this);
        attemptWidget.name = "attempt";
        addChild(attemptWidget);
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
        text.text = "Слот машина";
        text.x = rec.x;
        text.y = rec.y;

        addChild(headTextBox);
        addChild(text);
    }

    private function initDaysInGameWidget():void {
        var r:int = randomNumber(6, 1);
        daysInGameWidget = new DaysInGameWidget(r, rec);
        addChild(daysInGameWidget);
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

    private function initPrizeTableButton():void {
        prizeTableButton = new SimpleButton();
        prizeTableButton.x = rec.x / 4;
        prizeTableButton.y = rec.y / 4;

        prizeTableButton.upState = paintPrizeTableButton(0x00ff00);
        prizeTableButton.overState = paintPrizeTableButton(0x66ff00);
        prizeTableButton.downState = paintPrizeTableButton(0x7fff00);
        prizeTableButton.hitTestState = prizeTableButton.upState;

        prizeTableButton.addEventListener(MouseEvent.CLICK, prizeTableClickHandler);

        addChild(prizeTableButton);
    }

    private function paintPrizeTableButton(color:Number):Shape {
        var button:Shape = new Shape();
        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(rec.x + rec.width - 100, rec.y + rec.height - 40, 80, 20);
            endFill();
        }
        return button;
    }

    private function randomNumber(max:int, min:int = 0):int {
        return min + (max - min) * Math.random();
    }

    private function prizeTableClickHandler(event:MouseEvent):void {

    }

    private function exitClickHandler(event:MouseEvent):void {
        SlotMachine.setAttempt(attemptWidget.getAttempt());
        while (this.numChildren > 0) {
            this.removeChildAt(0);
        }
    }
}
}
