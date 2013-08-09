package Symbol {
public class AlphSimbol implements Symbol {
    private var gameWindow:GameWindow;
    private var symbol:Array;

    public function AlphSimbol(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;

        symbol = new Array("A", "B", "C", "D", "E");
    }

    public function getSymbols():Array {
        return symbol;
    }

    public function getEmptySymbol():String {
        return "X";
    }
}
}
