class GameScoreModel {
  int scoreNumber;
  GameScoreModel({required this.scoreNumber});
}

//next update
class HighestScore extends GameScoreModel {
  HighestScore({required super.scoreNumber});
}
