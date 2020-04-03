// page view state
import 'package:flutter/cupertino.dart';

enum PageViewStateValue {
  PageViewInit,
  PageViewLoadedSuccess,
  PageViewLoadedFail,
  PageViewShowFullScreenLoading,
  PageViewsEmpty
}

class PageViewState extends ChangeNotifier {
  PageViewState(PageViewStateValue state) : _state = state;

  PageViewStateValue _state = PageViewStateValue.PageViewInit;

  notifyPageState(PageViewStateValue state) {
    if (_state != state) {
      _state = state;
      notifyListeners();
    }
  }

  PageViewStateValue get state => _state;
}
