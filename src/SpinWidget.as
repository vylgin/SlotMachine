package {
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class SpinWidget extends Sprite {
    private var rec:Rectangle;
    private var spinButton:SimpleButton;

    public function SpinWidget(rec:Rectangle) {
        this.rec = rec;
        initSpinButton();
    }

    private function initSpinButton():void {
        spinButton = new SimpleButton();
        spinButton.x = rec.x / 4;
        spinButton.y = rec.y / 4;

        spinButton.upState = paintSpinButton(0x00ff00);
        spinButton.overState = paintSpinButton(0x66ff00);
        spinButton.downState = paintSpinButton(0x7fff00);
        spinButton.hitTestState = spinButton.upState;

        spinButton.addEventListener(MouseEvent.CLICK, spinButtonClickHandler);

        addChild(spinButton);
    }

    private function paintSpinButton(color:Number):Sprite {
        var x = rec.x + rec.width - 80;
        var y = rec.y + rec.height -210;
        var w = 40;
        var h = 80;

        var button:Sprite = new Sprite();
        with (button.graphics) {
            lineStyle(1, 0x000000);
            beginFill(color);
            drawRect(x, y, w, h);
            endFill();
        }

        var textField:TextField = new TextField();
        textField.text = "S\nP\nI\nN";
        textField.x = x;
        textField.y = y;
        textField.width = w;
        textField.height = h;
        textField.mouseEnabled = false;
        textField.setTextFormat(getCenterTextFormat());
        textField.defaultTextFormat = getCenterTextFormat();

        button.addChild(textField);

        return button;
    }

    private function getCenterTextFormat():TextFormat {
        var textFormat:TextFormat = new TextFormat();
        textFormat.align = TextFormatAlign.CENTER;
        return textFormat;
    }

    private function spinButtonClickHandler(event:MouseEvent):void {
        trace("Spin button clicked");
    }
}
}
