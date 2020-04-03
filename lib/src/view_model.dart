import 'package:flutter/material.dart';
import 'page_view_state.dart';

class ViewModel extends ChangeNotifier {
  final PageViewState pageViewState;
  ViewModel( 
    {pageViewStateValue : PageViewStateValue.PageViewInit})
    : pageViewState = PageViewState(pageViewStateValue);  
}
