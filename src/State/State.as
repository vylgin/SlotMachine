package State {
public interface State {
    function noPushSpin():void;
    function pushSpin():void;
    function startRotation():void;
    function finishRotation():void;
    function getPrize():void;
}
}
