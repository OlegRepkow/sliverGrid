import 'package:flutter/material.dart';
import 'package:grid_list/app_dimmens.dart';

class ItemModel extends StatelessWidget {
  const ItemModel({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppDimens.paddingExtraSmall),
        child: Container(
          color: Colors.green,
          child: Center(child: Text(title)),
        ),
      );
}
