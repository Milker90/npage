import 'package:flutter/material.dart';
import 'npage_view_state.dart';

class ViewModel extends ChangeNotifier {
  bool isDisposed = false;
  final NPageViewState pageViewState;
  ViewModel(this.pageViewState);
  ViewModel.pageValue({NPageViewStateValue pageViewStateValue = NPageViewStateValue.Init})
      : pageViewState = NPageViewState(state: pageViewStateValue);
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
