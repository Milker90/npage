import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;

  BuildContext context;

  setContext(BuildContext context) {
    if (context == null) context = context;
  }

  dynamic getModelView(BuildContext context) {
    assert(context == null, 'viewmodel context is null');
    return Provider.of<dynamic>(context, listen: false);
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
