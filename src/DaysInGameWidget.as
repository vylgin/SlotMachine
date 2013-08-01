package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import mx.core.FlexTextField;

public class DaysInGameWidget extends Sprite{
    private var day:uint;
    private var rec:Rectangle;

    private var daysBoxes:Vector.<Sprite>;

    public function DaysInGameWidget(day:uint, rec:Rectangle) {
        this.day = day;
        this.rec = rec;
        initGui();
    }

    public function get getDay():uint {
        return day;
    }

    private function initGui():void {
        initDaysBoxes();
    }

    private function initNameBox(msg:String):Sprite {
        var nameBox:Sprite = new Sprite();
        nameBox.x = rec.x;
        nameBox.y = rec.y;

        var textFormat:TextFormat = new TextFormat();
        textFormat.align = "center";
        var text:TextField = new TextField();
        text.text = msg;
        text.x = nameBox.x;
        text.y = nameBox.y;
        text.setTextFormat(textFormat);

        var nameTextBox:Shape = new Shape();
        with (nameTextBox.graphics) {
            lineStyle(1);
            beginFill(0xFFFFFF);
            drawRect(nameBox.x, nameBox.y, text.width, 20);
            endFill();
        }

        nameBox.addChild(nameTextBox);
        nameBox.addChild(text);
        return nameBox;
    }

    private function initDaysBoxes():void {
        daysBoxes = new Vector.<Sprite>();
        if (0 <= day && day <5) {
            daysBoxes.push(initNameBox("Дней в игре:"));
            var i:int;
            for (i = 1; i <= 5; i++) {
                createUsualDayBox(i);
            }
        } else if (day == 5 || day == 6) {
            daysBoxes.push(initNameBox("Особый день!"));
            createSuperDayBox();
        }

        for each (var sprite:Sprite in daysBoxes) {
            addChild(sprite);
        }
    }

    private function createUsualDayBox(i:int):void {
        var box:Sprite = new Sprite();

        switch (i) {
            case 1:
                box = getUsualDayBox(i, 195, 75, 20);
                break;
            case 2:
                box = getUsualDayBox(i, 235,75,  20);
                break;
            case 3:
                box = getUsualDayBox(i, 275,75, 20);
                break;
            case 4:
                box = getUsualDayBox(i, 315,75, 20);
                break;
            case 5:
                box = getUsualDayBox(i, 350,73, 24);
                break;
        }
        daysBoxes.push(box);
    }

    private function createSuperDayBox():void {
        var box:Sprite = new Sprite();
        box = getSuperDayBox(195, 75, 200, 20);
        daysBoxes.push(box);
    }

    private function getSuperDayBox(x:int, y:int, w:int, h:int):Sprite {
        var box:Sprite = new Sprite();
        var text:TextField = new TextField();

        with (box.graphics) {
            lineStyle(1, 0x000000);
            beginFill(0x00FF00);
            drawRect(x, y, w, h);
            endFill();
        }

        text.text = "Поздравляем, Вам выпал 5-ый день!!!";
        text.x = x;
        text.y = y;
        text.width = w;

        box.addChild(text);

        return box
    }

    private function getUsualDayBox(i:int, x:int, y:int, h:int):Sprite {
        var box:Sprite = new Sprite();
        var text:TextField = new TextField();

        with (box.graphics) {
            lineStyle(1, 0x000000);
            if (i <= day) {
                beginFill(0x00FF00);
            } else {
                beginFill(0xFFFFFF);
            }
            drawRect(x, y, 40, h);
            endFill();
        }

        text.text = String(i);
        text.x = x;
        text.y = y;

        box.addChild(text);

        return box
    }
}
}
