import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'core/cubits/game_cubit.dart';
import 'core/logic/game_images_provider.dart';
import 'core/routing/app_routing.dart';
import 'core/theme/game_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GameTheme().setSystemColors();
  runApp(const MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(GameImagesProvider(), AudioPlayer()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: GameTheme().getGameThemeData(),
        routerConfig: GameRouting.router,
      ),
    );
  }
}
