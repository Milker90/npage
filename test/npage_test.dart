import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:npage/npage.dart';

class MyViewModel extends ViewModel {

  MyViewModel({ NPageViewStateValue pageViewStateValue = NPageViewStateValue.Init}) 
  : super(pageViewStateValue : pageViewStateValue);
}

class MyPage extends NPageView {
  MyPage(
      {Key key,
      this.initName,
      this.successName,
      this.emptyName,
      this.loadingName,
      this.failedName});

  final String initName;
  final String successName;
  final String emptyName;
  final String loadingName;
  final String failedName;

  @override
  initData(BuildContext context) {
    return super.initData(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      child: Text(successName),
    );
  }

  @override
  Widget buildEmptyWidget(BuildContext context) {
    return Container(
      child: Text(emptyName),
    );
  }

  @override
  Widget buildFullScreenLoadingWidget(BuildContext context) {
    return Container(
      child: Text(loadingName),
    );
  }

  @override
  Widget buildInitWidget(BuildContext context) {
    return Container(
      child: Text(initName),
    );
  }

  @override
  Widget buildLoadedFailWidget(BuildContext context) {
    return Container(
      child: Text(failedName),
    );
  }

  @override
  emptyRetryCallback(BuildContext context) {}

  @override
  failRetryCallback(BuildContext context) {}
}

void main() {
  testWidgets('test page show init view', (WidgetTester tester) async {
    MyPage pageView = MyPage(
      initName: 'init',
    );
    MyViewModel viewModel = MyViewModel();
    var widget = NPageViewHelper.createPage(viewModel, pageView);
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));

    final retFinder = find.text('init');
    expect(retFinder, findsOneWidget);
  });

  testWidgets('test page show loading view', (WidgetTester tester) async {
    MyPage pageView = MyPage(
      loadingName: 'loading',
    );
    MyViewModel viewModel = MyViewModel(pageViewStateValue: NPageViewStateValue.ShowFullScreenLoading);
    var widget = NPageViewHelper.createPage(viewModel, pageView);
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));

    final retFinder = find.text('loading');
    expect(retFinder, findsOneWidget);
  });

  testWidgets('test page show success view', (WidgetTester tester) async {
    MyPage pageView = MyPage(
      successName: 'success',
    );
    MyViewModel viewModel = MyViewModel(pageViewStateValue: NPageViewStateValue.LoadedSuccess);
    var widget = NPageViewHelper.createPage(viewModel, pageView);
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));

    final retFinder = find.text('success');
    expect(retFinder, findsOneWidget);
  });

  testWidgets('test page show fail view', (WidgetTester tester) async {
    MyPage pageView = MyPage(
      failedName: 'fail',
    );
    MyViewModel viewModel = MyViewModel(pageViewStateValue: NPageViewStateValue.LoadedFail);
    var widget = NPageViewHelper.createPage(viewModel, pageView);
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));

    final retFinder = find.text('fail');
    expect(retFinder, findsOneWidget);
  });

  testWidgets('test page show empty view', (WidgetTester tester) async {
    MyPage pageView = MyPage(
      emptyName: 'empty',
    );
    MyViewModel viewModel = MyViewModel(pageViewStateValue: NPageViewStateValue.Empty);
    var widget = NPageViewHelper.createPage(viewModel, pageView);
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));

    final retFinder = find.text('empty');
    expect(retFinder, findsOneWidget);
  });
}
