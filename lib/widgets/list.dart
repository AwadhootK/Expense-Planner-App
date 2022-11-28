import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class Transac extends StatelessWidget {
  final Transactions obj;
  final Function deleteTransaction;

  const Transac({required this.obj, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(8),
        // color: Color.fromARGB(255, 114, 192, 252),
        color: Theme.of(context).primaryColorLight,
        elevation: 30,
        // shadowColor: Color.fromARGB(255, 84, 4, 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 45,
                  width: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.red,
                  ),
                  child: Text(
                    "\₹ " + "${obj.amount.toStringAsFixed(0)}",
                    style: TextStyle(
                        fontSize: 19,
                        // color: Color.fromARGB(255, 13, 43, 74),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  obj.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMMd().format(obj.date),
                  style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(
              width: 25,
            ),
            IconButton(
              onPressed: () {
                deleteTransaction(obj.id);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
