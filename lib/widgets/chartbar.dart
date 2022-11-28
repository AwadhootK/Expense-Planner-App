import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double spendpercent;

  ChartBar({
    required this.day,
    required this.amount,
    required this.spendpercent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shadowColor: Theme.of(context).primaryColorDark,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side:
              BorderSide(color: Theme.of(context).primaryColorDark, width: 1)),
      color: Colors.purple[50],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "₹${amount.toInt()}",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            width: 13,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Theme.of(context).primaryColorDark),
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),

                //FLEXIBLE DOES NOT WORK IN A STACK
                // Flexible(
                //   flex: spendpercent.toInt(),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Theme.of(context).primaryColorDark,
                //       //
                //     ),
                //   ),
                // ),

                FractionallySizedBox(
                  heightFactor: spendpercent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(day),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
