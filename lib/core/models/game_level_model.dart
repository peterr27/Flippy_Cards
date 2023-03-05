import '../enums/difficulty_enum.dart';

class GameLevelModel {
  int levelNumber;
  Difficulty difficulty;
  int scoreNumber;
  GameLevelModel({required this.levelNumber, required this.difficulty, required this.scoreNumber});
}
