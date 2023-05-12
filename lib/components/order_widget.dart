import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_flutter/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text('R\$ ${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          DateFormat(
            'dd/MM/yyyy hh:mm',
          ).format(order.date),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
