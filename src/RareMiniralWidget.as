package {
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;

public class RareMiniralWidget extends Sprite {
    private var rareMiniral:uint;
    private var gameWindow:GameWindow;
    private var rec:Rectangle;
    private var infoRareMineral:TextField;

    public function RareMiniralWidget(rareMiniral:uint, gameWindow:GameWindow, rec:Rectangle) {
        this.rareMiniral = rareMiniral;
        this.gameWindow = gameWindow;
        this.rec = rec;

        initInfoBox();
    }

    public function setRareMiniral(rareMiniral):void {
        this.rareMiniral = rareMiniral;
        updateInfoRareMineral();
    }

    public function getRareMiniral():uint {
        return rareMiniral;
    }

    private function updateInfoRareMineral():void {
        infoRareMineral.text = "      Количество редких минералов: " + rareMiniral;
    }

    private function initInfoBox():void {
        var x:int = rec.x / 4 + 87;
        var y:int = rec.y / 4 + 100;
        var w:int = 250;
        var h:int = 20;

        infoRareMineral = new TextField();
        infoRareMineral.x = x;
        infoRareMineral.y = y;
        infoRareMineral.width = w;
        infoRareMineral.height = h;
        infoRareMineral.border = true;
        infoRareMineral.background = true;
        infoRareMineral.backgroundColor = 0xFFFFFF;

        updateInfoRareMineral();

        addChild(infoRareMineral);
    }
}
}
