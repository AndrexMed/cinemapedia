import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/movie/:movieId',
    name: MovieScreen.name,
    builder: (context, state) {
      final movieId = state.pathParameters['movieId'] ?? 'No Id';
      return MovieScreen(movieId: movieId);
    },
  ),
]);
