package State {
public class StartRotationState implements State {
    private var gameWindow:GameWindow;

    public function StartRotationState(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;
    }

    public function noPushSpin():void {
    }

    public function pushSpin():void {
        trace("pushSpin in StartRotationState");
    }

    public function startRotation():void {
        gameWindow.getPrizeWidget().print("Воспользуйтесь кнопкой \"Таблица призов\",\nчтобы узнать доступные комбинации\nи призы.");

        gameWindow.getRollLineWidget().roll();
    }

    public function finishRotation():void {
    }

    public function getPrize():void {
    }
}
}
