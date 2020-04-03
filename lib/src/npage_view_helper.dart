
import 'package:provider/provider.dart';

import 'npage_view.dart';
import 'npage_view_state.dart';
import 'view_model.dart';

class NPageViewHelper {
  static MultiProvider
      createPage<T extends ViewModel, S extends NPageView>(
          T modelView, S pageView) {
    assert(modelView != null);
    assert(pageView != null);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NPageViewState>(create: (_) => modelView.pageViewState),
        ChangeNotifierProvider<T>(create: (_) => modelView),
      ],
      child: pageView,
    );
  }
}
