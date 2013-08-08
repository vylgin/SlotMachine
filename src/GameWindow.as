package {
import State.FinishRotationState;
import State.GetPrizeState;
import State.NoPushSpinState;
import State.PushSpinState;
import State.StartRotationState;
import State.State;

import avmplus.finish;

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
    private var rollLineWidget:RollLineWidget;

    private var noPushSpinState:State;
    private var pushSpinState:State;
    private var startRotationState:State;
    private var finishRotationState:State;
    private var getPrizeState:State;

    private var state:State;

    public function GameWindow(rec:Rectangle) {
        this.rec = rec;

        noPushSpinState = new NoPushSpinState(this);
        pushSpinState = new PushSpinState(this);
        startRotationState = new StartRotationState(this);
        finishRotationState = new FinishRotationState(this);
        getPrizeState = new GetPrizeState(this);

        state = noPushSpinState;

        initGui();

        state.noPushSpin();
    }

    public function getRollLineWidget():RollLineWidget {
        return rollLineWidget;
    }



    public function hideForAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            if (getChildAt(i).name != "attempt") {
                getChildAt(i).visible = false;
            }
        }
    }

    public function getSpinWidget():SpinWidget {
        return spinWidget;
    }

    public function getPrizeWidget():PrizeWidget {
        return prizeWidget;
    }

    public function getAttemptWidget():AttemptWidget {
        return attemptWidget;
    }

    public function showAfterAttemptDialog():void {
        var i:int;
        for (i = 0; i < numChildren; i++) {
            getChildAt(i).visible = true;
        }
    }

    public function setState(state:State):void {
        this.state = state;
    }

    public function getState():State {
        return state;
    }

    public function getNoPushSpinState():State {
        return noPushSpinState;
    }

    public function getPushSpinState():State {
        return pushSpinState;
    }

    public function getStartRotationState():State {
        return startRotationState;
    }

    public function getFinishRotationState():State {
        return finishRotationState;
    }

    public function getGetPrizeState():State {
        return getPrizeState;
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
        initRollLineWidget();
    }

    private function initRollLineWidget():void {
        rollLineWidget = new RollLineWidget(this, rec);
        addChild(rollLineWidget);
    }

    private function initSpinWidget():void {
        spinWidget = new SpinWidget(this, rec);
        addChild(spinWidget);
    }

    private function initPrizeWidget():void {
        prizeWidget = new PrizeWidget(rec);
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
