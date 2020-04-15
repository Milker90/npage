import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;

  BuildContext context;

  setContext(BuildContext c) {
    if (context != c) context = c;
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
