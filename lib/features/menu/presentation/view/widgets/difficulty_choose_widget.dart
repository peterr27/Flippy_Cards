import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cubits/game_cubit.dart';
import '../../../../../core/enums/difficulty_enum.dart';
import '../../../../../core/theme/game_colors/game_colors.dart';
import '../../../../../core/theme/game_text_styles/text_styles.dart';

class DifficultyChooseWidget extends StatefulWidget {
  const DifficultyChooseWidget({Key? key}) : super(key: key);

  @override
  State<DifficultyChooseWidget> createState() => _DifficultyChooseWidgetState();
}

class _DifficultyChooseWidgetState extends State<DifficultyChooseWidget> {
  final List<Difficulty> difficulties = [Difficulty.EASY, Difficulty.HARD, Difficulty.BEAST];
  Difficulty? dropText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: const Center(
          child: Text(
            'DIFFICULTY (CHANCES)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        value: dropText,
        items: difficulties
            .map(
              (item) => DropdownMenuItem<Difficulty>(
                value: item,
                child: Center(
                  child: Text(
                    item.name,
                    style: GameTextStyles.buttonTextStyle,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            dropText = value!;
          });
          BlocProvider.of<GameCubit>(context, listen: false).changeDifficulty(dropText ?? Difficulty.EASY);
        },
        buttonStyleData: ButtonStyleData(
          height: 56,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: GameColors.primaryColor,
            ),
            color: Colors.transparent,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: GameColors.primaryColor,
          iconDisabledColor: GameColors.primaryColor,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: GameColors.primaryColor.withOpacity(.2),
            border: Border.all(color: GameColors.primaryColor),
          ),
          elevation: 0,
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 45,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
