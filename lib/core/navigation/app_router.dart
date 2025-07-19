import 'package:go_router/go_router.dart';
import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';
import 'package:meme_editor_app/features/meme/presentation/features/home/home_page.dart';

import '../../features/meme/presentation/features/editor/editor_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/editor',
      name: 'editor',
      builder: (context, state) {
        final meme = state.extra as Meme;
        return EditorPage(meme: meme);
      },
    ),
  ],
);
