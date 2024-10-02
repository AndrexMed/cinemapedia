import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';
        return HomeScreen(pageIndex: int.parse(pageIndex));
      },
      routes: [
        GoRoute(
          path: 'movie/:movieId',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['movieId'] ?? 'No Id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ]),
]);
