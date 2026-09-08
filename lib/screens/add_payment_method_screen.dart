import 'package:flutter/material.dart';
import 'package:pocket_track/core/payment_method.dart';
import 'package:pocket_track/core/payment_method_provider.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key, this.paymentMethod});
  final PaymentMethod? paymentMethod;

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final TextEditingController nameController = TextEditingController();

  PaymentType? selectedType;

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethod != null) {
      nameController.text = widget.paymentMethod!.name;
      selectedType = widget.paymentMethod!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    PaymentMethodProvider db = context.read<PaymentMethodProvider>();

    void pop() {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }

    Future<void> save() async {
      if (nameController.text.isEmpty || selectedType == null) return;
      PaymentMethod newMethod;
      if (widget.paymentMethod != null) {
        newMethod = widget.paymentMethod!
          ..name = nameController.text
          ..type = selectedType!;
      } else {
        newMethod = PaymentMethod()
          ..name = nameController.text
          ..type = selectedType!;
      }
      await db.save(newMethod);
      pop();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Añadir método de pago')),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              label: Text('Nombre'),
              hint: Text('BBVA'),
            ),
          ),
          DropdownButton<PaymentType>(
            value: selectedType,
            items: [
              ...PaymentType.values.map(
                (category) => DropdownMenuItem(
                  onTap: () {
                    selectedType = category;
                  },
                  value: category,
                  child: Text(category.name),
                ),
              ),
            ],
            selectedItemBuilder: (context) {
              return [
                ...PaymentType.values.map(
                  (category) => DropdownMenuItem(
                    onTap: () {},
                    value: category,
                    child: Text(category.name),
                  ),
                ),
              ];
            },
            onChanged: (PaymentType? value) {
              setState(() {
                selectedType = value;
              });
            },
          ),
          FilledButton(onPressed: save, child: Text('Guardar')),
        ],
      ),
    );
  }
}
