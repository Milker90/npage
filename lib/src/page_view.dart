import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_build_widget.dart';
import 'page_view_state.dart';
import 'view_model.dart';

abstract class PageView<T extends ViewModel, S extends PageViewState> extends StatelessWidget
    implements PageBuildWidget {
  
  initData(BuildContext context) {

  }

  T getModelView(BuildContext context, {bool listent: true}) {
    return Provider.of<T>(context, listen: listent);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${this.runtimeType} is building');
    initData(context);
    return Consumer<S>(
      builder: (context, pageState, child) {
      if (pageState.state == PageViewStateValue.PageViewInit) {
        return buildInitWidget(context);
      } else if (pageState.state == PageViewStateValue.PageViewShowFullScreenLoading) {
        return buildFullScreenLoadingWidget(context);
      } else if (pageState.state == PageViewStateValue.PageViewLoadedFail) {
        return buildLoadedFailWidget(
          context
        );
      } else if (pageState.state ==
          PageViewStateValue.PageViewLoadedSuccess) {
        return buildContent(context);
      } else if (pageState.state == PageViewStateValue.PageViewsEmpty) {
        return buildEmptyWidget(context);
      } else {
        debugPrint(
            'build page view failed: ${pageState.state} is not support');
        return Container(child: null);
      }
    });
  }
}
