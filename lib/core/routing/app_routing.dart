import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/game/presentation/view/game_view.dart';
import '../../features/images/presentation/view/images_view.dart';
import '../../features/levels/presentation/view/levels_view.dart';
import '../../features/menu/presentation/view/menu_view.dart';

abstract class GameRouting {
  static const kHomeViewId = '/';
  static const kGameViewId = '/game';
  static const kLevelsViewId = '/levels';
  static const kImagesViewId = '/images';

  static GoRoute makeNewRoute(String routeId, Widget routeWidget) {
    return GoRoute(
      path: routeId,
      builder: (BuildContext context, GoRouterState state) {
        return routeWidget;
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: routeWidget,
      ),
    );
  }

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      makeNewRoute(kHomeViewId, const MenuView()),
      makeNewRoute(kGameViewId, const GameView()),
      makeNewRoute(kLevelsViewId, const LevelsView()),
      makeNewRoute(kImagesViewId, const ImagesView()),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    transitionDuration: const Duration(milliseconds: 70),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
  );
}
