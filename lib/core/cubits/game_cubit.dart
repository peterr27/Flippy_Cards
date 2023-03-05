import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../constants.dart';
import '../enums/difficulty_enum.dart';
import '../logic/game_images_provider.dart';
import '../models/game_image_model.dart';
import '../models/game_level_model.dart';
import '../models/game_life_model.dart';
import '../models/game_pair_model.dart';
import '../models/game_score_model.dart';
import 'game_cubit_states.dart';

class GameCubit extends Cubit<GameCubitStates> {
  GameCubit(this._imagesProvider, this._player) : super(initialValues);
  final GameImagesProvider _imagesProvider;
  final AudioPlayer _player;
  static final GameScoreModel _scoreModel = GameScoreModel(scoreNumber: 0);
  static final GameLifeCountModel _lifeModel = GameLifeCountModel(lifeCount: 10);
  static final GameLevelModel _level =
      GameLevelModel(difficulty: Difficulty.EASY, levelNumber: LevelNumberConstants.levelNames[0], scoreNumber: _scoreModel.scoreNumber);
  static final GamePairImagesModel _pairModel = GamePairImagesModel(firstImage: GameImage(), secondImage: GameImage());
  final GameImage? _firstImage = _pairModel.firstImage;
  final GameImage? _secondImage = _pairModel.secondImage;
  static final initialValues = GameCubitInitialValuesState(
    gameScoreModel: _scoreModel,
    difficulty: _level.difficulty,
    gameLifeModel: _lifeModel,
    level: _level,
    imagesFolderName: 'lol',
  );

  //references to track index of images and get current image path
  int? _currentIndex;
  int? _previousIndex;
  String _currentImagePath = '';
  /////////////////////////////////////////////
  //the list that is decide which image should be visible
  //the list that has the images that will be displayed
  List<GameImage> images = [];
  List<bool> imagesVisibility = [];

  //BASED ON IS TWO IMAGES EQUAL WE DEFINE LIST OF BOOL TO MAKE  IMAGES  HIDDEN OR VISIBLE
///////////////////////////////////////////////////////////////////
  //Main FUNCTIONS ON CHECK EQUALITY >
  _actionOnCurrentIndexEqualToIndex() {
    imagesVisibility[_currentIndex!] = !imagesVisibility[_currentIndex!];
    _currentImagePath = images[_currentIndex!].imagePath!;
  }

  _actionOnCurrentIndexNotEqualToIndex(int index) async {
    _currentImagePath = GameImage.setImagePath(images[index].imagePath)!;
    if (_firstImage!.imagePath == null) {
      _actionOnFirstImagePathEqualNull(index);
    } else if (_firstImage!.imagePath != null) {
      await _actionOnFirstImagePathNotEqualNull(index);
    }
  }

  _actionOnFirstImagePathEqualNull(int index) {
    _currentIndex = index;
    _firstImage!.imagePath = GameImage.setImagePath(_currentImagePath);
    _firstImage!.imageIndex = GameImage.setIndex(_currentIndex);
    imagesVisibility[_firstImage!.imageIndex!] = true;
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
  }

  _actionOnFirstImagePathNotEqualNull(int index) async {
    _previousIndex = _currentIndex;
    _currentIndex = index;
    _secondImage!.imagePath = GameImage.setImagePath(_currentImagePath);
    _secondImage!.imageIndex = GameImage.setIndex(_currentIndex);
    _firstImage!.imageIndex = GameImage.setIndex(_previousIndex);
    imagesVisibility[_secondImage!.imageIndex!] = true;
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));

    if (GamePairImagesModel.compareImages(_firstImage!, _secondImage!)) {
      await _actionOnGamePairImageModelIsEqual();
    } else {
      await _actionOnGamePairImageModelIsNotEqual();
    }
  }

  _actionOnGamePairImageModelIsEqual() async {
    _pairModel.isTheSameImage = true;
    imagesVisibility[_firstImage!.imageIndex!] = true;
    imagesVisibility[_secondImage!.imageIndex!] = true;
    _currentIndex = null;
    _previousIndex = null;
    _currentImagePath = '';
    _firstImage!.imagePath = null;
    _secondImage!.imagePath = null;
    initialValues.scoreModel!.scoreNumber = initialValues.scoreModel!.scoreNumber + 500;
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
    _detectWin();
    await _player.setAsset('lib/assets/sounds/yes.wav');
    await _player.play();
  }

  _actionOnGamePairImageModelIsNotEqual() async {
    _pairModel.isTheSameImage = false;
    imagesVisibility[_secondImage!.imageIndex!] = true;
    await Future.delayed(const Duration(milliseconds: 300));
    imagesVisibility[_firstImage!.imageIndex!] = false;
    imagesVisibility[_secondImage!.imageIndex!] = false;
    _currentIndex = null;
    _previousIndex = null;
    _currentImagePath = '';
    _firstImage!.imagePath = null;
    _secondImage!.imagePath = null;
    if (initialValues.scoreModel!.scoreNumber != 0) {
      initialValues.scoreModel!.scoreNumber = initialValues.scoreModel!.scoreNumber - 500;
    }
    _detectLose();
    await _player.setAsset('lib/assets/sounds/no.wav');
    await _player.play();
  }

  _detectWin() async {
    bool isAllMatching = imagesVisibility.every((element) => element == true);
    if (isAllMatching) {
      emit(GameCubitWinState(level: _level.levelNumber));
    }
  }

  _detectLose() async {
    if (initialValues.lifeCountModel!.lifeCount <= 1) {
      emit(GameCubitLoseState(score: _scoreModel.scoreNumber));
    } else {
      initialValues.lifeCountModel!.lifeCount = initialValues.lifeCountModel!.lifeCount - 1;
      emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
    }
  }

///////////////////////////////////////////////////////////////////

  void createGameWithInitialValuesAndImagesBasedOnLevel() async {
    images = await _imagesProvider.createImages(_level.levelNumber, initialValues.imagesFolderName!);
    imagesVisibility = List.generate(images.length, (index) => true);
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
  }

  void changeLevel(int levelNumber) {
    _level.levelNumber = levelNumber;
    emit(initialValues);
  }
  // void changeImages(String imageFolder) {
  //   _level.levelNumber = levelNumber;
  //   emit(initialValues);
  // }

  void changeScore(int newScore) {
    _scoreModel.scoreNumber = newScore;
    emit(initialValues);
  }

  void changeImages(String imagesFolderName) {
    initialValues.imagesFolderName = imagesFolderName;
    emit(initialValues);
  }

  void changeDifficulty(Difficulty difficulty) {
    _level.difficulty = difficulty;
    switch (difficulty) {
      case Difficulty.EASY:
        _lifeModel.lifeCount = 10;
        break;
      case Difficulty.HARD:
        _lifeModel.lifeCount = 5;
        break;
      case Difficulty.BEAST:
        _lifeModel.lifeCount = 3;
        break;
    }
    emit(initialValues);
  }

  void changeImagesPositionsAndStartAgain() async {
    images.shuffle();
    imagesVisibility = List.generate(images.length, (index) => true);
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
  }

  Future startGame() async {
    await Future.delayed(const Duration(milliseconds: 150));
    imagesVisibility = List.generate(images.length, (index) => false);
    emit(GameCubitDataIsAvailableState(gameCubitDataFromInitialValues: initialValues, images: images, imagesVisibility: imagesVisibility));
  }

  checkEquality(int index) {
    if (_currentIndex == index) {
      _actionOnCurrentIndexEqualToIndex();
    } else if (_currentIndex != index) {
      _actionOnCurrentIndexNotEqualToIndex(index);
    }
  }

  void startOverFromLosing() async {
    images = await _imagesProvider.createImages(_level.levelNumber, 'lol');
    _scoreModel.scoreNumber = _scoreModel.scoreNumber ~/ 2;
    changeDifficulty(_level.difficulty);
    imagesVisibility = List.generate(images.length, (index) => true);
    emit(initialValues);
  }
}
