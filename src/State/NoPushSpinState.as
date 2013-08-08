package State {
public class NoPushSpinState implements State {
    private var gameWindow:GameWindow;

    public function NoPushSpinState(gameWindow:GameWindow) {
        this.gameWindow = gameWindow;
    }

    public function noPushSpin():void {
        if (gameWindow.getAttemptWidget().getAttempt() > 0) {
            gameWindow.getSpinWidget().setSpinButtonEnabled(true);
            gameWindow.setState(gameWindow.getPushSpinState());

        } else {
            gameWindow.getSpinWidget().setSpinButtonEnabled(false);
        }

        if (gameWindow.getRollLineWidget().notRolls()) {
            gameWindow.getPrizeWidget().print("Нажмите на рычаг и испытайте\nсвою удачу!");
        }
    }

    public function pushSpin():void {
    }

    public function startRotation():void {
    }

    public function finishRotation():void {
    }

    public function getPrize():void {
    }
}
}
