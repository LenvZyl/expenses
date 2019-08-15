import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _addNewTransaction(BuildContext context) {
    final enteredTitle = titleController.text;
    final enteredamount = double.tryParse(amountController.text);

    FocusScope.of(context).requestFocus(new FocusNode());
    if (enteredTitle.isEmpty ||
        enteredamount == null ||
        enteredamount <= 0 ||
        _selectedDate == null) {
      return _showAlert(context, "Invalid Fields Entered");
    }
    widget.addTransaction(enteredTitle, enteredamount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: new Text('OK'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => _addNewTransaction(context),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  controller: amountController,
                  onSubmitted: (_) => _addNewTransaction(context),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(_selectedDate != null
                          ? DateFormat.yMMMd().format(_selectedDate)
                          : "No date selected"),
                      FlatButton(
                        child: Text(
                          'Select date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _presentDatePicker();
                        },
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  onPressed: () => _addNewTransaction(context),
                )
              ],
            )),
          )),
    );
  }
}
