import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_colors/game_colors.dart';

class GameTheme {
  static final GameTheme _gameTheme = GameTheme._internal();
  factory GameTheme() {
    return _gameTheme;
  }
  GameTheme._internal();
  ////////////////////////////////////////////
  void setSystemColors() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    ));
  }

  ThemeData getGameThemeData() {
    return ThemeData(
      fontFamily: 'Play',
      backgroundColor: GameColors.primaryColor,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(GameColors.primaryColor),
            surfaceTintColor: MaterialStateProperty.all(GameColors.primaryColor),
            overlayColor: MaterialStateProperty.all<Color?>(GameColors.primaryColor),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shape:
                MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: GameColors.primaryColor), borderRadius: BorderRadius.circular(12)))),
      ),
    );
  }
}
