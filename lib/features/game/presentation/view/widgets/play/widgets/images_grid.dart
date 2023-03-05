import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../constants.dart';
import '../../../../../../../core/cubits/game_cubit.dart';
import '../../../../../../../core/cubits/game_cubit_states.dart';
import 'image_item.dart';

class ImagesGridList extends StatelessWidget {
  const ImagesGridList({required this.state, Key? key}) : super(key: key);
  final GameCubitDataIsAvailableState state;
  void onTapDisabled() {}

  void onTapEnabled(int index, BuildContext context) {
    BlocProvider.of<GameCubit>(context).checkEquality(index);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 5, crossAxisSpacing: 10, mainAxisSpacing: MediaQuery.of(context).size.width / 40 + 5),
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  onTap: () async {
                    if (!state.imagesVisibility[index]) {
                      onTapEnabled(index, context);
                    } else {
                      onTapDisabled();
                    }
                  },
                  child: ImageItem(
                    imageName: state.imagesVisibility[index] ? state.images[index].imagePath! : PathsConstants.unknownImagePath,
                  ),
                );
              }, childCount: state.images.length),
            ),
          ],
        ),
      ),
    );
  }
}
