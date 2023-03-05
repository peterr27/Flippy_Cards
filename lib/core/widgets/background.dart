import 'package:flutter/material.dart';

import '../../constants.dart';
import '../theme/game_dimensions/dimensions.dart';

class GameBackgroundImage extends StatelessWidget {
  const GameBackgroundImage({required this.viewBody, this.viewPaddingFromTop, Key? key}) : super(key: key);
  final Widget viewBody;
  final double? viewPaddingFromTop;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.fromLTRB(
        GameDimensions.viewHorizontalPadding,
        viewPaddingFromTop ?? MediaQuery.of(context).viewInsets.top + 50,
        GameDimensions.viewHorizontalPadding,
        0,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            PathsConstants.backgroundImagePath,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: viewBody,
    );
  }
}

//////////////////////////////////////////////////////////
