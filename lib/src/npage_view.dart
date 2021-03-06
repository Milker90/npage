import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'npage_build_widget.dart';
import 'npage_view_state.dart';
import 'view_model.dart';

abstract class NPageView<T extends ViewModel, S extends NPageViewState> extends StatelessWidget
    implements NPageBuildWidget {
  NPageView({Key key}) : super(key: key);

  initData(BuildContext context) {}

  T getModelView(BuildContext context, {bool listen: true}) {
    return Provider.of<T>(context, listen: listen);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${this.runtimeType} is building');
    getModelView(context, listen: false).setContext(context);
    initData(context);
    return Consumer<S>(builder: (context, pageState, child) {
      if (pageState.state == NPageViewStateValue.Init) {
        return buildInitWidget(context);
      } else if (pageState.state == NPageViewStateValue.ShowFullScreenLoading) {
        return buildFullScreenLoadingWidget(context);
      } else if (pageState.state == NPageViewStateValue.LoadedFail) {
        return buildLoadedFailWidget(context);
      } else if (pageState.state == NPageViewStateValue.LoadedSuccess) {
        return buildContent(context);
      } else if (pageState.state == NPageViewStateValue.Empty) {
        return buildEmptyWidget(context);
      } else {
        debugPrint('build page view failed: ${pageState.state} is not support');
        return Container(child: null);
      }
    });
  }
}
