import 'package:flutter/material.dart';
import '../models/transactions.dart';
import '../widgets/list.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function delTransac;

  TransactionList({required this.transactions, required this.delTransac});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        height: 490,

        // use ListView.builder for long lists so that performance is better as only those
        //widgets are rendered which are visible on the screen
        child: transactions.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(25)),
                      alignment: Alignment.topCenter,
                      child: Card(
                        elevation: 25,
                        shadowColor: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "NO TRANSACTIONS YET!",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 30,
                    shadowColor: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: 300,
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage("images/dog.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Transac(
                    obj: transactions[index],
                    deleteTransaction: delTransac,
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
