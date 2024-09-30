import 'package:cinemapedia/presentation/delegates/search_movie%20_delegate.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.movie_creation, size: 30, color: colors.primary),
                  Text('CinemaPedia', style: titleStyle),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: SearchMovieDelegate());
                    },
                    icon: const Icon(Icons.search),
                    color: colors.primary,
                  ),
                ],
              ),
            )));
  }
}
