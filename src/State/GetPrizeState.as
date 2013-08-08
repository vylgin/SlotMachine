package State {
public class GetPrizeState implements State {
    private var gameWindow:GameWindow;

    public function GetPrizeState(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;
    }

    public function noPushSpin():void {
    }

    public function pushSpin():void {
    }

    public function startRotation():void {
    }

    public function finishRotation():void {
    }

    public function getPrize():void {
        if(gameWindow.getAttemptWidget().getAttempt() == 0) {
            gameWindow.getPrizeWidget().print("Вот Ваш приз!\nЗакончились попытки!\nПополните их, нажав на кнопку \"Добавить\"");
        } else {
            gameWindow.getPrizeWidget().print("Вот Ваш приз!");
        }
        gameWindow.setState(gameWindow.getNoPushSpinState());
        gameWindow.getState().noPushSpin();
    }
}
}
