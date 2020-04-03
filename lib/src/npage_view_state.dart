// page view state
import 'package:flutter/cupertino.dart';

enum NPageViewStateValue {
  Init,
  LoadedSuccess,
  LoadedFail,
  ShowFullScreenLoading,
  Empty
}

class NPageViewState extends ChangeNotifier {
  NPageViewState(NPageViewStateValue state) : _state = state;

  NPageViewStateValue _state = NPageViewStateValue.Init;

  notifyPageState(NPageViewStateValue state) {
    if (_state != state) {
      _state = state;
      notifyListeners();
    }
  }

  NPageViewStateValue get state => _state;
}
