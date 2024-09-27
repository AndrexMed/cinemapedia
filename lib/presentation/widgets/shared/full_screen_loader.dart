import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    final messages = <String>[
      'Cargando...',
      'Cargando. . .',
      'Cargando. . . . .',
      'Cargando. . . . . . .',
      'Cargando. . . . . . . . .',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 1000),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor...'),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: getLoadingMessage(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando...');

                return Text(snapshot.data!);
              }),
        ],
      ),
    );
  }
}
