import 'package:provider/provider.dart';

import 'npage_view.dart';
import 'npage_view_state.dart';
import 'view_model.dart';

class NPageViewHelper {
  static MultiProvider createPageWithPT<P extends NPageView, T extends ViewModel>(P pageView, T modelView) {
    assert(modelView != null);
    assert(pageView != null);
    return createPageWithPTS<P, T, NPageViewState>(pageView, modelView, NPageViewState());
  }

  static MultiProvider createPageWithPTS<P extends NPageView, T extends ViewModel, S extends NPageViewState>(
      P pageView, T modelView, S pageStae) {
    assert(modelView != null);
    assert(pageView != null);
    assert(pageStae != null);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<S>(create: (_) => pageStae),
        ChangeNotifierProvider<T>(create: (_) => modelView),
      ],
      child: pageView,
    );
  }
}
