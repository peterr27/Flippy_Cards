import 'package:flippy_cards/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/cubits/game_cubit.dart';
import '../../../../../../core/routing/app_routing.dart';
import '../../../../../../core/theme/game_text_styles/text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';

class LostWidget extends StatelessWidget {
  const LostWidget({required this.score, Key? key}) : super(key: key);
  final int score;
  @override
  Widget build(BuildContext context) {
    final verticalSpace = 20.sv;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'YOU LOST ALL CHANCES!',
            style: GameTextStyles.resultTextStyle,
          ),
        ),
        verticalSpace,
        Center(
          child: Text(
            'SCORE : $score',
            style: GameTextStyles.resultTextStyle,
          ),
        ),
        verticalSpace,
        GameCustomButton(
            name: 'TRY AGAIN',
            onTap: () {
              BlocProvider.of<GameCubit>(context, listen: false).startOverFromLosing();
              GoRouter.of(context).pushReplacement(GameRouting.kHomeViewId);
            })
      ],
    );
  }
}
