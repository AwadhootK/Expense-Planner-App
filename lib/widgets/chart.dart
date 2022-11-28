import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'chartbar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getgroupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          sum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get totalWeeklySpending {
    double weeklyspendings = 0.0;
    for (int i = 0; i < recentTransactions.length; i++) {
      weeklyspendings += recentTransactions[i].amount;
    }
    return weeklyspendings;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Theme.of(context).primaryColorDark)),
      color: Theme.of(context).primaryColorLight,
      elevation: 15,
      // margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getgroupedTransactions.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  day: tx['day'].toString(),
                  amount: double.parse(tx['amount'].toString()),
                  spendpercent: totalWeeklySpending != 0.0
                      ? double.parse((double.parse(tx['amount'].toString()) /
                              totalWeeklySpending)
                          .toString())
                      : 0.0),
            );
          }).toList(),
        ),
      ),
    );
  }
}
