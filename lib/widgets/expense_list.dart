import 'package:flutter/material.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/expense_details_screen.dart';
import 'package:pocket_track/widgets/filter_options.dart';

final List<String> weekDays = ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sáb', 'Dom'];

final List<String> months = [
  'Ene',
  'Feb',
  'Mar',
  'Abr',
  'May',
  'Jun',
  'Jul',
  'Ago',
  'Sep',
  'Oct',
  'Nov',
  'Dic',
];

Widget expenseList({
  required void Function(bool?) setItemsToShow,
  required bool? isExpense,
  required double totalIncome,
  required double totalExpense,
  required List<Expense> transactions,
  required List<Expense> expenses,
  required List<Expense> incomes,
  required DateTime date,
}) {
  DateTime currentDate = date;
  DateTime lastDate = date;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: CustomScrollView(
      slivers: [
        FilterOptions(setItemsToShow: setItemsToShow),
        SliverToBoxAdapter(
          child: isExpense == null
              ? Text(
                  'Balance: \$${totalIncome - totalExpense}',
                  style: TextStyle(
                    color: (totalIncome - totalExpense) < 0
                        ? Colors.deepOrangeAccent
                        : Colors.green,
                  ),
                )
              : isExpense == true
              ? Text(
                  'Total expense: $totalExpense',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                )
              : Text(
                  'Total income: $totalIncome',
                  style: TextStyle(color: Colors.green),
                ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              List<Expense> itemsToShow = isExpense == null
                  ? transactions
                  : isExpense == true
                  ? expenses
                  : incomes;
              final expense = itemsToShow[index];
              if (index == 0) {
                currentDate = expense.date;
                lastDate = DateTime.fromMicrosecondsSinceEpoch(0);
              } else {
                lastDate = currentDate;
                currentDate = expense.date;
              }
              if (lastDate.day != currentDate.day) {
                return Column(
                  children: [
                    Container(
                      color: Color(0x4A4A1ABA),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: Text(weekDays[currentDate.weekday - 1]),
                          ),
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: Text('${currentDate.day}'),
                          ),
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: Text(months[currentDate.month - 1]),
                          ),
                          SizedBox(
                            width: 60,
                            height: 30,
                            child: Text('${currentDate.year}'),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ExpenseDetailsScreen(expense: expense),
                          ),
                        );
                      },
                      child: Container(
                        color: index % 2 == 0
                            ? Color(0xFFFFFFFF)
                            : Color(0xEEEEEEEE),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: expense.isExpense
                                  ? Text('Gasto')
                                  : Text('Ingreso'),
                            ),
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: Text(
                                expense.category.value?.name ?? '',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: Text(expense.description ?? ''),
                            ),
                            SizedBox(
                              width: 60,
                              height: 40,
                              child: Text(
                                '${expense.amount}',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExpenseDetailsScreen(expense: expense),
                    ),
                  );
                },
                child: Container(
                  color: index % 2 == 0 ? Color(0xFFFFFFFF) : Color(0xEEEEEEEE),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60,
                        child: expense.isExpense
                            ? Text('Gasto')
                            : Text('ingreso'),
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Text(
                          expense.category.value?.name ?? '',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Text(expense.description ?? ''),
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Text(
                          '${expense.amount}',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount:
                (isExpense == null
                        ? transactions
                        : isExpense == true
                        ? expenses
                        : incomes)
                    .length,
          ),
        ),
      ],
    ),
  );
}
