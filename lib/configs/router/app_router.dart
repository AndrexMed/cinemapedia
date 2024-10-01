// import 'package:cinemapedia/presentation/views/views.dart';
// import 'package:go_router/go_router.dart';

// import '../../presentation/screens/screens.dart';

// final appRouter = GoRouter(initialLocation: '/', routes: [
//   //Rutas Padre/Hijo
//   // GoRoute(
//   //     path: '/',
//   //     name: HomeScreen.name,
//   //     builder: (context, state) => const HomeScreen(
//   //           childView: HomeView(),
//   //         ),
//   //     routes: [
//   //       GoRoute(
//   //         path: 'movie/:movieId',
//   //         name: MovieScreen.name,
//   //         builder: (context, state) {
//   //           final movieId = state.pathParameters['movieId'] ?? 'No Id';
//   //           return MovieScreen(movieId: movieId);
//   //         },
//   //       ),
//   //     ]),
//   ShellRoute(
//       builder: (context, state, child) => HomeScreen(childView: child),
//       routes: [
//         GoRoute(
//             path: '/',
//             builder: (context, state) {
//               return const HomeView();
//             },
//             routes: [
//               GoRoute(
//                 path: 'movie/:movieId',
//                 name: MovieScreen.name,
//                 builder: (context, state) {
//                   final movieId = state.pathParameters['movieId'] ?? 'No Id';
//                   return MovieScreen(movieId: movieId);
//                 },
//               ),
//             ]),
//         GoRoute(
//           path: '/favorites',
//           builder: (context, state) => const FavoritesView(),
//         )
//       ])
// ]);
