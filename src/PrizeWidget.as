package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class PrizeWidget extends Sprite {
    private var rec:Rectangle;
    private var prizeBox:Sprite;
    private var textFieldPrizeBox:TextField;

    public function PrizeWidget(rec:Rectangle) {
        this.rec = rec;
        initPrizeWidget();
    }

    public function print(str:String):void {
        textFieldPrizeBox.text = str;
    }

    private function initPrizeWidget():void {
        var w = 250;
        var h = 72;
        prizeBox = new Sprite();
        prizeBox.x = rec.x;
        prizeBox.y = rec.y + 90;

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = TextFormatAlign.CENTER;

        textFieldPrizeBox = new TextField();
        textFieldPrizeBox.x = prizeBox.x;
        textFieldPrizeBox.y = prizeBox.y;
        textFieldPrizeBox.width = w;
        textFieldPrizeBox.height = h;
        textFieldPrizeBox.mouseEnabled = false;
        textFieldPrizeBox.setTextFormat(textFormat);
        textFieldPrizeBox.defaultTextFormat = textFormat;

        var recInfoBox:Shape = new Shape();
        with (recInfoBox.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(prizeBox.x, prizeBox.y, w, h);
            endFill();
        }

        prizeBox.addChild(recInfoBox);
        prizeBox.addChild(textFieldPrizeBox);
        addChild(prizeBox);
    }

    public function setFigure(figure:Sprite):void {
        prizeBox.addChild(figure);
    }
}
}
