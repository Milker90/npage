import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;

  BuildContext context;

  setContext(BuildContext context) {
    if (context == null) context = context;
  }
  
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
