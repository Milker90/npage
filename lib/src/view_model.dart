import 'package:flutter/material.dart';
import 'npage_view_state.dart';

class ViewModel extends ChangeNotifier {
  final NPageViewState pageViewState;
  ViewModel( 
    {pageViewStateValue : NPageViewStateValue.Init})
    : pageViewState = NPageViewState(pageViewStateValue);  
}
