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
        var text:String = gameWindow.getRollLineWidget().getPrize();
        if(gameWindow.getAttemptWidget().getAttempt() == 0) {
            gameWindow.getPrizeWidget().print(text + "\nЗакончились попытки!\nПополните их, нажав на кнопку \"Добавить\"");
        } else {
            gameWindow.getPrizeWidget().print(text);
        }
        gameWindow.setState(gameWindow.getNoPushSpinState());
        gameWindow.getState().noPushSpin();
    }
}
}
