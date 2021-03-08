import 'package:flutter/material.dart';

class LoadingDialog {
  static show({
    BuildContext context,
    String text,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ],
          ),
        );
      },
    );
  }
}
