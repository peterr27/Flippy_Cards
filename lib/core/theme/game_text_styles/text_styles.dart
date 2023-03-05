import 'package:flutter/material.dart';
import '../game_colors/game_colors.dart';

abstract class GameTextStyles {
  static final TextStyle titleTextStyle = TextStyle(fontSize: 40, color: GameColors.primaryColor, letterSpacing: 2);
  static final TextStyle buttonTextStyle = TextStyle(fontSize: 18, color: GameColors.whiteColor, letterSpacing: 2, fontWeight: FontWeight.w700);
  static final TextStyle buttonTextStyleSmall = TextStyle(fontSize: 14, color: GameColors.whiteColor, fontWeight: FontWeight.bold, letterSpacing: 2);
  static final TextStyle resultTextStyle = TextStyle(fontSize: 28, color: GameColors.whiteColor, fontWeight: FontWeight.bold, letterSpacing: 2);
  static final TextStyle startTextStyle = TextStyle(fontSize: 22, color: GameColors.whiteColor, fontWeight: FontWeight.w900, letterSpacing: 4);
  static final TextStyle peterTextStyle = TextStyle(fontSize: 12, color: GameColors.primaryColor, fontWeight: FontWeight.w900, letterSpacing: 4);
}
