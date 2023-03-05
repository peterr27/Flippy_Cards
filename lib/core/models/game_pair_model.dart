import 'game_image_model.dart';

class GamePairImagesModel {
  GameImage? firstImage;
  GameImage? secondImage;
  bool isTheSameImage;

  GamePairImagesModel({this.firstImage, this.secondImage, this.isTheSameImage = false});

  static bool compareImages(GameImage firstImage, GameImage secondImage) {
    bool isEqual = firstImage.imagePath == secondImage.imagePath ? true : false;
    return isEqual;
  }
}
