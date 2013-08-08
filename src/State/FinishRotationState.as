package State {
public class FinishRotationState implements State {
    private var gameWindow:GameWindow;

    public function FinishRotationState(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;
    }

    public function noPushSpin():void {
    }

    public function pushSpin():void {
    }

    public function startRotation():void {
    }

    public function finishRotation():void {
        gameWindow.getPrizeWidget().print("Возможно Вы получили приз!");
        gameWindow.setState(gameWindow.getGetPrizeState());
        gameWindow.getState().getPrize();
    }

    public function getPrize():void {
    }
}
}
