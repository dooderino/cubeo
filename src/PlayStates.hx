enum abstract PlayStates(Int) {
    MyTurn;
    Waiting;
    PlaceRedDice;
    PlaysBlueDice;
    MoveRedDice;
    MoveBlueDice;
    MoveOrPromoteRedDice;
    MoveOrPromoteBlueDice;
}