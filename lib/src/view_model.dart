import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;

  BuildContext context;

  setContext(BuildContext c) {
    if (context == null) context = c;
  }
  
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
