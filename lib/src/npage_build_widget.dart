import 'package:flutter/cupertino.dart';

abstract class NPageBuildWidget {
  // build init widget
  Widget buildInitWidget(BuildContext context);

  // build fullscreen loading widget
  Widget buildFullScreenLoadingWidget(BuildContext context);

  // build success widget
  Widget buildContent(BuildContext context);

  // build loaded fail widget
  Widget buildLoadedFailWidget(BuildContext context);

  // retry reload page after loaded fail
  failRetryCallback(BuildContext context);

  // build empty widget
  Widget buildEmptyWidget(BuildContext context);

  // retry reload page after the page is empty
  emptyRetryCallback(BuildContext context);
}
