package State {
public class PushSpinState implements State {
    private var gameWindow:GameWindow;

    public function PushSpinState(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;
    }

    public function noPushSpin():void {
    }

    public function pushSpin():void {
        var attemptWidget = gameWindow.getAttemptWidget();
        if (attemptWidget.getAttempt() > 0) {
            attemptWidget.setAttempt(attemptWidget.getAttempt() - 1);
        }
        gameWindow.setState(gameWindow.getStartRotationState());
        gameWindow.getState().startRotation();
    }

    public function startRotation():void {
    }

    public function finishRotation():void {
    }

    public function getPrize():void {
    }
}
}
