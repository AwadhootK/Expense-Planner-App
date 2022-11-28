import 'package:flutter/material.dart';
import './user_transactions.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTransaction;
  final Function clearTransaction;

  NewTransactions({
    required this.addTransaction,
    required this.clearTransaction,
  });

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0.0 || selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop(); //to close the topmost widget
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity, //min: 220
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Purchase Name",
                ),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Purchase Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                selectedDate == null
                    ? "Select Purchase Date"
                    : "Selected Date: " +
                        DateFormat.yMMMd().format(selectedDate!).toString(),
                style: TextStyle(
                    color: selectedDate != null
                        ? Theme.of(context).primaryColor
                        : Colors.grey[600],
                    fontWeight: selectedDate != null
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight),
                onPressed: presentDatePicker,
                child: Text(
                  "Choose Date",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Theme.of(context).primaryColorDark),
                ),
                elevation: 20,
                shadowColor: Theme.of(context).primaryColorDark,
                child: Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              // backgroundColor: Colors.blue[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              side: BorderSide(
                                  width: 1,
                                  // color: Color.fromARGB(255, 15, 56, 89),
                                  color: Theme.of(context).primaryColorDark)),
                          onPressed: submitData,
                          child: Text(
                            'Add Transaction',
                            // style: TextStyle(color: Colors.blue[900]),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              // backgroundColor: Colors.blue[100],
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              side: BorderSide(
                                  width: 1,
                                  // color: Color.fromARGB(255, 15, 56, 89),
                                  color: Theme.of(context).primaryColorDark)),
                          onPressed: () {
                            widget.clearTransaction();
                          },
                          child: Text(
                            "Clear List",
                            // style: TextStyle(color: Colors.blue[900]),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
