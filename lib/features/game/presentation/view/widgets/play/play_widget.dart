import 'package:flippy_cards/features/game/presentation/view/widgets/play/widgets/images_grid.dart';
import 'package:flippy_cards/features/game/presentation/view/widgets/play/widgets/information_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/cubits/game_cubit.dart';
import '../../../../../../core/cubits/game_cubit_states.dart';
import '../../../../../../core/theme/game_text_styles/text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget({required this.state, Key? key}) : super(key: key);
  final GameCubitDataIsAvailableState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        InformationContainer(state: state),
        ImagesGridList(state: state),
        GameCustomButton(
          onTap: () {
            BlocProvider.of<GameCubit>(context).startGame();
          },
          name: 'START',
          buttonTextStyle: GameTextStyles.startTextStyle,
        ),
      ],
    );
  }
}
