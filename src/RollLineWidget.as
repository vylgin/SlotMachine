package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Timer;

public class RollLineWidget extends Sprite {
    private var gameWindow:GameWindow;
    private var rec:Rectangle;
    private var rollLineBox:Sprite;

    private var oneTextField:TextField;
    private var twoTextField:TextField;
    private var threeTextField:TextField;

    private var oneRow:Sprite;
    private var twoRow:Sprite;
    private var threeRow:Sprite;

    private var emptySymbol:String;

    private var symbol:Array;

    var randomOne:int;
    var randomTwo:int;
    var randomThree:int;

    public function RollLineWidget(gameWindow:GameWindow, rec:Rectangle) {
        this.gameWindow = gameWindow;
        this.rec = rec;

        emptySymbol = gameWindow.getSymbol().getEmptySymbol();

        initRollLineWidget();
        initRows();
    }

    public function roll():void {
        symbol = gameWindow.getSymbol().getSymbols();

        randomOne = randomNumber(5, 0);
        randomTwo = randomNumber(5, 0);
        randomThree = randomNumber(5, 0);

        oneTextField.text = " ";
        twoTextField.text = " ";
        threeTextField.text = " ";

        var timer:Timer = new Timer(1000, 4);
        timer.addEventListener(TimerEvent.TIMER, onTick);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        timer.start();
    }

    private function onTick(event:TimerEvent):void {
        switch (event.target.currentCount) {
            case 1:
                oneTextField.text = symbol[randomOne];
                break;
            case 2:
                twoTextField.text = symbol[randomTwo];
                break;
            case 3:
                threeTextField.text = symbol[randomThree];
                break;
        }
    }

    private function onTimerComplete(event:TimerEvent):void {
        gameWindow.setState(gameWindow.getFinishRotationState());
        gameWindow.getState().finishRotation();
    }

    public function notRolls():Boolean {
        if (oneTextField.text == emptySymbol &&
                twoTextField.text == emptySymbol &&
                threeTextField.text == emptySymbol) {
            return true;
        } else {
            return false;
        }
    }

    private function initRollLineWidget():void {
        var w = 250;
        var h = 80;
        rollLineBox = new Sprite();
        rollLineBox.x = rec.x;
        rollLineBox.y = rec.y + 31;

        var recInfoBox:Shape = new Shape();
        with (recInfoBox.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(rollLineBox.x, rollLineBox.y, w, h);
            endFill();
        }

        rollLineBox.addChild(recInfoBox);
        addChild(rollLineBox);
    }

    private function initRows():void {
        oneRow = new Sprite();
        twoRow = new Sprite();
        threeRow = new Sprite();

        var x:int = rollLineBox.x + 15;
        var y:int = rollLineBox.y + 10;
        oneRow.addChild(paintRow(x, y));
        twoRow.addChild(paintRow(x + 80, y));
        threeRow.addChild(paintRow(x + 160, y));

        oneTextField = paintText(x, y);
        twoTextField = paintText(x + 80, y);
        threeTextField = paintText(x + 160, y);

        oneRow.addChild(oneTextField);
        twoRow.addChild(twoTextField);
        threeRow.addChild(threeTextField);

        rollLineBox.addChild(oneRow);
        rollLineBox.addChild(twoRow);
        rollLineBox.addChild(threeRow);
    }

    private function paintRow(x:int, y:int):Shape {
        var row:Shape = new Shape();
        with (row.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(x, y, 60, 60);
            endFill();
        }
        return row;
    }

    private function paintText(x:int, y:int):TextField {
        var textField:TextField = new TextField();
        textField.text = emptySymbol;
        textField.x = x;
        textField.y = y;
        textField.width = 60;
        textField.height = 60;
        textField.mouseEnabled = false;
        textField.setTextFormat(getCenterTextFormat());
        textField.defaultTextFormat = getCenterTextFormat();

        return textField;
    }

    private function randomNumber(max:int, min:int = 0):int {
        return min + (max - min) * Math.random();
    }

    private function getCenterTextFormat():TextFormat {
        var textFormat:TextFormat = new TextFormat();
        textFormat.align = TextFormatAlign.CENTER;
        textFormat.size = 50;
        return textFormat;
    }
}
}
