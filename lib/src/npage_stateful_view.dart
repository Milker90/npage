import 'package:flutter/material.dart';
import 'package:npage/npage.dart';
import 'package:provider/provider.dart';

import 'npage_view_state.dart';

class NPageStatefulView extends StatefulWidget {
  NPageStatefulView({Key key}) : super(key: key);

  @override
  NPageStatefulViewState createState() => NPageStatefulViewState();
}

class NPageStatefulViewState<T extends ViewModel, S extends NPageViewState> extends State<NPageStatefulView> with AutomaticKeepAliveClientMixin implements NPageBuildWidget{

  @override
  void initState() {   
    initData(null);  
    super.initState();    
  }

  initData(BuildContext context) {}

  T getModelView(BuildContext context, {bool listen: true}) {
    return Provider.of<T>(context, listen: listen);
  }

  @override
  Widget build(BuildContext context) {    
    debugPrint('${this.runtimeType} is building');
    super.build(context);
    getModelView(context, listen: false).setContext(context);
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

  @override
  Widget buildContent(BuildContext context) {
      // TODO: implement buildContent
      throw UnimplementedError();
    }
  
    @override
    Widget buildEmptyWidget(BuildContext context) {
      // TODO: implement buildEmptyWidget
      throw UnimplementedError();
    }
  
    @override
    Widget buildFullScreenLoadingWidget(BuildContext context) {
      // TODO: implement buildFullScreenLoadingWidget
      throw UnimplementedError();
    }
  
    @override
    Widget buildInitWidget(BuildContext context) {
      // TODO: implement buildInitWidget
      throw UnimplementedError();
    }
  
    @override
    Widget buildLoadedFailWidget(BuildContext context) {
      // TODO: implement buildLoadedFailWidget
      throw UnimplementedError();
    }
  
    @override
    emptyRetryCallback(BuildContext context) {
      // TODO: implement emptyRetryCallback
      throw UnimplementedError();
    }
  
    @override
    failRetryCallback(BuildContext context) {
    // TODO: implement failRetryCallback
    throw UnimplementedError();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}