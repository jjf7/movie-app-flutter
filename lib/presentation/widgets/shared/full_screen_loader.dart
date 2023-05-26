import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key}) : super(key: key);

  Stream<String> getLoadingMessages() {
    final List<String> messages = [
      'Cargando peliculas',
      'Comprando palomitas de maiz',
      'Cargando peliculas en cines',
      'Cargando peliculas populares',
      '....',
      'Ummm...',
      'Yaaaa',
    ];

    return Stream.periodic(const Duration(milliseconds: 1500), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
