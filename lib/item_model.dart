import 'package:flutter/material.dart';

class ItemModel extends StatelessWidget {
  const ItemModel({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        color: Colors.green,
        child: Text(title),
      );
}
