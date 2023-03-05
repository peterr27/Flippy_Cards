class GameImage {
  String? imagePath;
  int? imageIndex;

  GameImage({this.imagePath, this.imageIndex});

  static String? setImagePath(String? image) {
    final imagePath = image;
    return imagePath;
  }

  static int? setIndex(int? indexOfImage) {
    final index = indexOfImage;
    return index;
  }
}
