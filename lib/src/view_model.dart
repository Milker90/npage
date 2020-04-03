import 'package:flutter/material.dart';
import 'page_view_state.dart';

class BaseModelView extends ChangeNotifier {
  final PageViewState pageViewState;
  BaseModelView( 
    {pageViewStateValue : PageViewStateValue.PageViewInit})
    : pageViewState = PageViewState(pageViewStateValue);  
}
