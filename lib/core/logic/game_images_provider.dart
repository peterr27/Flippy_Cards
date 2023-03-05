import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/game_image_model.dart';

class GameImagesProvider {
  Future<List<String>> _getImagesFromAssets(String folderName) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys.where((String key) => key.contains('images/game/$folderName/')).where((String key) => key.contains('.png')).toList();
    return imagePaths;
  }

  //create Images Model of strings
  //public function to create images based on folderName
  Future<List<GameImage>> createImages(int levelName, String folderName) async {
    List<String> imagesPath = await _getImagesFromAssets(folderName);
    imagesPath.shuffle();
    List<GameImage> images = [];
    for (int i = 0; i < imagesPath.length; i++) {
      if (i < levelName) {
        images.add(GameImage(imagePath: imagesPath[i], imageIndex: i));
        images.add(GameImage(imagePath: imagesPath[i], imageIndex: i));
      }
    }
    images.shuffle();
    return images;
  }
}
