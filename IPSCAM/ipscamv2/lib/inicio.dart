import 'package:flutter/material.dart';

void main() => runApp(const inicio());

class inicio extends StatelessWidget {
  const inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inicio',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pantalla de Inicio'),
        ),
        body: const Center(
          child: Text('Inicio'),
        ),
      ),
    );
  }
}
