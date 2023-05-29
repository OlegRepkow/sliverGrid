import 'package:flutter/material.dart';

extension Dialogs on BuildContext {
  Future<void> showLoadingIndicator({
    required String alertTitle,
  }) =>
      showDialog(
        context: this,
        builder: (context) => Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                alertTitle,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
}
