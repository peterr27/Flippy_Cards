import 'package:flippy_cards/features/game/presentation/view/widgets/play/widgets/play_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../core/cubits/game_cubit.dart';
import '../../../../../../../core/cubits/game_cubit_states.dart';
import '../../../../../../../core/routing/app_routing.dart';
import '../../../../../../../core/theme/game_colors/game_colors.dart';
import '../../../../../../../core/theme/game_text_styles/text_styles.dart';
import '../../../../../../../core/widgets/custom_button.dart';

class InformationContainer extends StatelessWidget {
  const InformationContainer({required this.state, Key? key}) : super(key: key);
  final GameCubitDataIsAvailableState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InformationWidget(
                title: 'SCORE',
                info: state.gameCubitDataFromInitialValues.scoreModel!.scoreNumber.toString(),
              ),
              InformationWidget(
                title: 'LEVEL',
                info: state.gameCubitDataFromInitialValues.level!.levelNumber.toString(),
              ),
              InformationWidget(
                title: 'CHANCES',
                info: state.gameCubitDataFromInitialValues.lifeCountModel!.lifeCount.toString(),
              ),
              InformationWidget(
                title: 'DIFFICULTY',
                info: state.gameCubitDataFromInitialValues.level!.difficulty.name.toString(),
              ),
            ],
          ),
        ),
        GameCustomButton(
          name: 'HOME',
          buttonTextStyle: GameTextStyles.buttonTextStyleSmall,
          onTap: () {
            GoRouter.of(context).pushReplacement(GameRouting.kHomeViewId);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5),
          child: Row(
            children: [
              Expanded(
                child: GameCustomButton(
                  name: 'CHANGE ORDER',
                  buttonTextStyle: GameTextStyles.buttonTextStyleSmall,
                  onTap: () {
                    BlocProvider.of<GameCubit>(context).changeImagesPositionsAndStartAgain();
                  },
                ),
              ),
              Expanded(
                child: GameCustomButton(
                  name: 'CHANGE LEVEL',
                  buttonTextStyle: GameTextStyles.buttonTextStyleSmall,
                  onTap: () {
                    GoRouter.of(context).pushReplacement(GameRouting.kLevelsViewId);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 5),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'MEMORIZE WHERE IMAGES ARE PLACED THEN PRESS START',
              style: TextStyle(color: GameColors.primaryColor, letterSpacing: 2, fontWeight: FontWeight.w800, fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
