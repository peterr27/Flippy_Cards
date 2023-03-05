import 'package:flutter/material.dart';

import '../../../../../../../core/theme/game_colors/game_colors.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({required this.imageName, Key? key}) : super(key: key);
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: GameColors.primaryColor, width: 1.2), borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Image.asset(
          imageName,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
