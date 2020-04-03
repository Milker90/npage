
import 'package:provider/provider.dart';

import 'page_view.dart';
import 'page_view_state.dart';
import 'view_model.dart';

class PageViewHelper {
  static MultiProvider
      createPage<T extends ViewModel, S extends PageView>(
          T modelView, S pageView) {
    assert(modelView == null);
    assert(pageView == null);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageViewState>(create: (_) => modelView.pageViewState),
        ChangeNotifierProvider<T>(create: (_) => modelView),
      ],
      child: pageView,
    );
  }
}
