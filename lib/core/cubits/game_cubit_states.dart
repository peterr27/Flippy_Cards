import '../enums/difficulty_enum.dart';
import '../models/game_image_model.dart';
import '../models/game_level_model.dart';
import '../models/game_life_model.dart';
import '../models/game_score_model.dart';

abstract class GameCubitStates {}

class GameCubitInitialValuesState extends GameCubitStates {
  static final GameCubitInitialValuesState _singleton = GameCubitInitialValuesState._internal();
  GameScoreModel? scoreModel;
  GameLifeCountModel? lifeCountModel;
  Difficulty? difficulty;
  GameLevelModel? level;
  String? imagesFolderName;
  GameCubitInitialValuesState._internal();
  factory GameCubitInitialValuesState(
      {required GameScoreModel gameScoreModel,
      required GameLifeCountModel gameLifeModel,
      required Difficulty difficulty,
      required GameLevelModel level,
      required String imagesFolderName}) {
    _singleton.scoreModel = gameScoreModel;
    _singleton.lifeCountModel = gameLifeModel;
    _singleton.difficulty = difficulty;
    _singleton.level = level;
    _singleton.imagesFolderName = imagesFolderName;
    return _singleton;
  }
}

class GameCubitDataIsAvailableState extends GameCubitStates {
  GameCubitInitialValuesState gameCubitDataFromInitialValues;
  List<GameImage> images;
  List<bool> imagesVisibility;
  GameCubitDataIsAvailableState({required this.gameCubitDataFromInitialValues, required this.images, required this.imagesVisibility});
}

class GameCubitWinState extends GameCubitStates {
  int level;
  GameCubitWinState({required this.level});
}

class GameCubitLoseState extends GameCubitStates {
  int score;
  GameCubitLoseState({required this.score});
}
