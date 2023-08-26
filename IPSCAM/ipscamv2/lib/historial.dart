import 'package:flutter/material.dart';

void main() => runApp(const historial());

class historial extends StatelessWidget {
  const historial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Historial',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla de Historial'),
        ),
        body: const Center(
          child: Text('Historial'),
        ),
      ),
    );
  }
}
