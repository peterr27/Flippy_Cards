import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants.dart';
import '../../../../core/cubits/game_cubit.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../../core/theme/game_colors/game_colors.dart';
import '../../../../core/widgets/background.dart';
import '../../../../core/widgets/custom_button.dart';

class LevelsView extends StatelessWidget {
  const LevelsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackgroundImage(
        viewBody: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: 20,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: GameColors.primaryColor.withOpacity(.2)),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {
                    final canPop = GoRouter.of(context).canPop();
                    if (canPop) {
                      GoRouter.of(context).pop();
                    } else {
                      GoRouter.of(context).pushReplacement(GameRouting.kGameViewId);
                    }
                  },
                ),
              ),
            ),
            SliverFillRemaining(
              child: GridView.builder(
                itemCount: LevelNumberConstants.levelNames.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1, crossAxisSpacing: 20, mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GameCustomButton(
                    name: LevelNumberConstants.levelNames[index].toString(),
                    onTap: () {
                      BlocProvider.of<GameCubit>(context, listen: false).changeLevel(LevelNumberConstants.levelNames[index]);
                      BlocProvider.of<GameCubit>(context, listen: false).createGameWithInitialValuesAndImagesBasedOnLevel();
                      GoRouter.of(context).pushReplacement(GameRouting.kGameViewId);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
