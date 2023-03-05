import 'package:flutter/material.dart';
import '../theme/game_dimensions/dimensions.dart';
import '../theme/game_text_styles/text_styles.dart';

class GameCustomButton extends StatefulWidget {
  const GameCustomButton({required this.name, required this.onTap, this.buttonTextStyle, Key? key}) : super(key: key);
  final VoidCallback onTap;
  final String name;
  final TextStyle? buttonTextStyle;

  @override
  State<GameCustomButton> createState() => _GameCustomButtonState();
}

class _GameCustomButtonState extends State<GameCustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black54,
      ),
      onPressed: widget.onTap,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: GameDimensions.buttonTextPadding),
          child: Text(
            widget.name,
            style: widget.buttonTextStyle ?? GameTextStyles.buttonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
