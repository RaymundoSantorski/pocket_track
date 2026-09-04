import 'package:flutter/material.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  AddPaymentMethodScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir método de pago')),
      body: Column(
        children: [
          Card(child: Column(children: [TextField(), TextField()])),
          FilledButton(onPressed: () {}, child: Text('Guardar')),
        ],
      ),
    );
  }
}
