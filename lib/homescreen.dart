import 'package:flutter/material.dart';
import 'package:pocket_track/core/database.dart';
import 'package:pocket_track/core/expense.dart';
import 'package:pocket_track/screens/add_expense_screen.dart';
import 'package:pocket_track/screens/expense_details_screen.dart';
import 'package:pocket_track/widgets/filter_options.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> itemsToShow = [];
  bool? isExpense;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        itemsToShow = context.read<Database>().transactions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Expense> transactions = context.watch<Database>().transactions;
    List<Expense> expenses = context.watch<Database>().expenses;
    List<Expense> incomes = context.watch<Database>().incomes;
    double totalIncome = context.watch<Database>().totalIncome;
    double totalExpense = context.watch<Database>().totalExpense;
    DateTime currentDate = DateTime.now();
    DateTime lastDate = DateTime.now();
    final List<String> weekDays = [
      'Lun',
      'Mar',
      'Mie',
      'Jue',
      'Vie',
      'Sáb',
      'Dom',
    ];

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

    ColorScheme theme = Theme.of(context).colorScheme;

    void setItemsToShow(bool? value) {
      setState(() {
        isExpense = value;
      });
      switch (value) {
        case true:
          setState(() {
            itemsToShow = expenses;
          });
          return;
        case false:
          setState(() {
            itemsToShow = incomes;
          });
          return;
        default:
          setState(() {
            itemsToShow = transactions;
          });
      }
      setState(() {});
    }

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          widget.title,
          style: TextStyle(
            color: theme.onPrimary,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: itemsToShow.isEmpty
            ? Container()
            : Padding(
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
                      delegate: SliverChildBuilderDelegate((context, index) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Text(
                                        weekDays[currentDate.weekday - 1],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Text('${currentDate.day}'),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Text(
                                        months[currentDate.month - 1],
                                      ),
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
                                      builder: (_) => ExpenseDetailsScreen(
                                        expense: expense,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: index % 2 == 0
                                      ? Color(0xFFFFFFFF)
                                      : Color(0xEEEEEEEE),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          expense.category.name,
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
                                  child: expense.isExpense
                                      ? Text('Gasto')
                                      : Text('ingreso'),
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 40,
                                  child: Text(
                                    expense.category.name,
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
                        );
                      }, childCount: itemsToShow.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
