import 'package:flippy_cards/features/game/presentation/view/widgets/lose/lose_widget.dart';
import 'package:flippy_cards/features/game/presentation/view/widgets/play/play_widget.dart';
import 'package:flippy_cards/features/game/presentation/view/widgets/win/win_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubits/game_cubit.dart';
import '../../../../core/cubits/game_cubit_states.dart';
import '../../../../core/widgets/background.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackgroundImage(
        viewPaddingFromTop: MediaQuery.of(context).viewInsets.top + 35,
        viewBody: BlocBuilder<GameCubit, GameCubitStates>(
          builder: (context, state) {
            if (state is GameCubitDataIsAvailableState) {
              return PlayWidget(state: state);
            } else if (state is GameCubitLoseState) {
              return LostWidget(score: state.score);
            } else if (state is GameCubitWinState) {
              return const WinWidget();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
