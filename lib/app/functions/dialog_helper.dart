import 'package:flutter/material.dart';
import 'package:meminder/main.dart';

showLoadingDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) {
      return const AlertDialog(
        content: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

hideDialog() {
  Navigator.of(navigatorKey.currentContext!).pop();
}
