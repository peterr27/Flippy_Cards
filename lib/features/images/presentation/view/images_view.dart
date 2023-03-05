import 'package:flippy_cards/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/cubits/game_cubit.dart';
import '../../../../core/routing/app_routing.dart';
import '../../../../core/widgets/background.dart';

class ImagesView extends StatelessWidget {
  const ImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalSpace = 20.sv;
    return Scaffold(
      body: GameBackgroundImage(
        viewBody: ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black54),
              onPressed: () {
                BlocProvider.of<GameCubit>(context, listen: false).changeImages('lol');
                BlocProvider.of<GameCubit>(context, listen: false).createGameWithInitialValuesAndImagesBasedOnLevel();

                GoRouter.of(context).pushReplacement(GameRouting.kGameViewId);
              },
              child: ListTile(
                leading: Image.asset('lib/assets/images/game/lol/01.png'),
                title: Text(
                  'LEAGUE OF LEGENDS',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            verticalSpace,
            ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black54),
              onPressed: () {
                BlocProvider.of<GameCubit>(context, listen: false).changeImages('hero');
                BlocProvider.of<GameCubit>(context, listen: false).createGameWithInitialValuesAndImagesBasedOnLevel();
                GoRouter.of(context).pushReplacement(GameRouting.kGameViewId);
              },
              child: ListTile(
                leading: Image.asset('lib/assets/images/game/hero/01.png'),
                title: Text(
                  'RANDOM SUPERHEROS',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            verticalSpace
          ],
        ),
      ),
    );
  }
}
