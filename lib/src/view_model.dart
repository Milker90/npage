import 'package:flutter/material.dart';
import 'npage_view_state.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;
  final NPageViewState pageViewState;
  ViewModel({pageViewStateValue: NPageViewStateValue.Init}) : pageViewState = NPageViewState(pageViewStateValue);

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
