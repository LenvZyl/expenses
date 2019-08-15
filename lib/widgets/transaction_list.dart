import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeItemAtIndex;

  TransactionList(this.transactions, this.removeItemAtIndex);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text("No Transactions added", style: Theme.of(context).textTheme.title,),
                  SizedBox(height: 20),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Dismissible(
                      key: Key(transactions[index].title),
                      onDismissed: (direction) {
                        removeItemAtIndex(index);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('\$${transactions[index].amount}')),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(transactions[index].date)),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
