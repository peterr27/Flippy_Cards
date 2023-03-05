import 'package:flippy_cards/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/cubits/game_cubit.dart';
import '../../../../../../core/cubits/game_cubit_states.dart';
import '../../../../../../core/routing/app_routing.dart';
import '../../../../../../core/theme/game_text_styles/text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';

class WinWidget extends StatelessWidget {
  const WinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSpace = 20.sv;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'GOOD JOB!',
            style: GameTextStyles.resultTextStyle,
          ),
        ),
        verticalSpace,
        BlocBuilder<GameCubit, GameCubitStates>(builder: (context, state) {
          final winState = state as GameCubitWinState;
          if (winState.level != 20) {
            return GameCustomButton(
                name: 'Next Level',
                onTap: () {
                  BlocProvider.of<GameCubit>(context, listen: false).changeLevel(winState.level + 1);
                  BlocProvider.of<GameCubit>(context, listen: false).createGameWithInitialValuesAndImagesBasedOnLevel();
                });
          } else {
            return GameCustomButton(
                name: 'HOME',
                onTap: () {
                  GoRouter.of(context).pushReplacement(GameRouting.kHomeViewId);
                });
          }
        }),
      ],
    );
  }
}
