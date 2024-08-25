import 'dart:math';

import 'package:flutter/material.dart';

import '../models/user_balance.dart';
import '../services/backend.dart';

class SettleView extends StatefulWidget {
  const SettleView({super.key, required this.userBalances});

  final List<UserBalance> userBalances;

  @override
  State<SettleView> createState() => _SettleViewState();
}

class _SettleViewState extends State<SettleView> {
  List<Map<String, dynamic>> payments = [];

  @override
  void initState() {
    super.initState();

    final userBalances = widget.userBalances.map((e) => e.toMap());

    List<Map<String, dynamic>> positive =
        userBalances.where((e) => e['balances'] > 0).toList();
    positive.sort((a, b) => b['balances'] - a['balances']);

    List<Map<String, dynamic>> negative =
        userBalances.where((e) => e['balances'] < 0).toList();
    negative.sort((a, b) => a['balances'] - b['balances']);

    int i = 0;
    while (i < negative.length) {
      if (negative[i]['balances'] == 0) continue;

      int j = 0;
      while (j < positive.length) {
        if (positive[j]['balances'] == 0) continue;

        int maximumPayment =
            min(positive[j]['balances'], -negative[i]['balances']);

        payments.add({
          'from': negative[i]['user_id'],
          'fromName': negative[i]['name'],
          'to': positive[j]['user_id'],
          'toName': positive[j]['name'],
          'amount': maximumPayment,
          'selected': false
        });

        negative[i]['balances'] += maximumPayment;
        positive[j]['balances'] -= maximumPayment;

        j += 1;
      }

      i += 1;
    }
  }

  _savePayments() {
    payments = payments.where((e) => e['selected']).toList();
    savePayments(payments).then((val) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Expense Saved.')),
        );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Failed to save expense.')),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (payments.any((e) => e['selected']))
            TextButton(
              onPressed: _savePayments,
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text('Save payments'),
              ),
            )
        ],
      ),
      body: payments.isEmpty
          ? const Center(
              child: Text('All settle up!'),
            )
          : ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 50,
                );
              },
              itemCount: payments.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('From ${payments[index]['fromName']}'),
                  subtitle: Text('To ${payments[index]['toName']}'),
                  secondary: Text('INR ${payments[index]['amount']}'),
                  onChanged: (val) {
                    setState(() {
                      payments[index]['selected'] =
                          !payments[index]['selected'];
                    });
                  },
                  value: payments[index]['selected'],
                );
              },
            ),
    );
  }
}
