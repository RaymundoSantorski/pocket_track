import 'package:flutter/material.dart';

class FilterOptions extends StatefulWidget {
  const FilterOptions({super.key, required this.setItemsToShow});
  final void Function(bool?) setItemsToShow;

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  bool? isExpense;
  void onSelect(bool? value) {
    setState(() {
      isExpense = value;
    });
    widget.setItemsToShow(value);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            label: Text('Todo'),
            selected: isExpense == null,
            onSelected: (_) => onSelect(null),
            selectedColor: Colors.lightBlueAccent,
            showCheckmark: false,
          ),
          ChoiceChip(
            label: Text('Expenses'),
            selected: isExpense == true,
            onSelected: (_) => onSelect(true),
            selectedColor: Colors.redAccent,
            showCheckmark: false,
          ),
          ChoiceChip(
            label: Text('Incomes'),
            selected: isExpense == false,
            onSelected: (_) => onSelect(false),
            showCheckmark: false,
          ),
        ],
      ),
    );
  }
}
