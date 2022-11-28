import 'package:flutter/material.dart';
import 'widgets/trasaction_list.dart';
import 'widgets/new_transactions.dart';
import 'widgets/trasaction_list.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    int r, g, b;
    r = 20;
    g = 100;
    b = 200;
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

    return MaterialApp(
      title: 'EXPENSE PLANNER APP',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.red[500],
        errorColor: Colors.red[700],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    // Transactions(
    //   id: "Transaction 1",
    //   amount: 2000,
    //   name: "Headphones",
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: "Transaction 2",
    //   amount: 4000,
    //   name: "Shoes",
    //   date: DateTime.now(),
    // ),
  ];

  List<Transactions> get recentTransactions {
    return _userTransactions.where((transac) {
      return transac.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        amount: amount,
        name: title,
        date: chosenDate);

    setState(() {
      // width = 0.0;
      _userTransactions.add(newTx);
    });
  }

  void _removeTransactions() {
    setState(() {
      _userTransactions.clear();
    });
  }

  void _deleteTransaction(String ide) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == ide;
      });
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bContext) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(
              addTransaction: _addNewTransaction,
              clearTransaction: _removeTransactions,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EXPENSE PLANNER"),
        actions: [
          IconButton(
            color: Theme.of(context).primaryColorLight,
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
            // color: Colors.blue[900],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Chart(recentTransactions),
                TransactionList(
                  transactions: _userTransactions,
                  delTransac: _deleteTransaction,
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
