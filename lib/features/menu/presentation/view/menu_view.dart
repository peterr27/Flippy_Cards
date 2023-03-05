import 'package:flippy_cards/core/extensions.dart';
import 'package:flippy_cards/features/menu/presentation/view/widgets/difficulty_choose_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/cubits/game_cubit.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../../core/theme/game_text_styles/text_styles.dart';
import '../../../../core/widgets/background.dart';
import '../../../../core/widgets/custom_button.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSpace = 20.sv;
    return Scaffold(
      body: GameBackgroundImage(
        viewBody: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'FLIPPY CARDS',
                        style: GameTextStyles.titleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalSpace,
                    GameCustomButton(
                      name: 'START GAME',
                      onTap: () {
                        BlocProvider.of<GameCubit>(context, listen: false).createGameWithInitialValuesAndImagesBasedOnLevel();
                        GoRouter.of(context).pushReplacement(GameRouting.kGameViewId);
                      },
                    ),
                    verticalSpace,
                    GameCustomButton(
                      name: 'LEVELS',
                      onTap: () {
                        GoRouter.of(context).push(GameRouting.kLevelsViewId);
                      },
                    ),
                    verticalSpace,
                    GameCustomButton(
                      name: 'IMAGES',
                      onTap: () {
                        GoRouter.of(context).push(GameRouting.kImagesViewId);
                      },
                    ),
                    verticalSpace,
                    const DifficultyChooseWidget(),
                  ],
                ),
              ),
            ),
            Container(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '\u00a9PETER ABDO @LINKIDIN',
                  style: GameTextStyles.peterTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
