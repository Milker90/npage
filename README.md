# npage

npage is a simple and fast library to implement basic pages. It uses MVVM architecture.

## Installing
```
    dependencies:
        npage: "^1.0.0"
```

## Usage

1, Create class to inherit ViewModel
```
    class HomeViewModel extends ViewModel {
        // remember call super, if custom constructor, because ViewModel needs to create PageViewState instance
        // Finally, when using pageviewhelper to create a MultiProvider, HomeViewModel and PageViewState will be added at the same time
        // if want to change page state, call pageViewState.notifyPageState(state), pageViewState is in top node use Provider, so If HomeViewModel and PageViewState change at the same time，call only pageViewState.notifyPageState

        HomeViewModel(data, {PageViewStateValue pageViewStateValue}) : 
        _data = data, 
        super(pageViewStateValue: pageViewStateValue);

        int _data;
        bool _isInitData = false;

        // Use notifyListeners to update require specific nodes 
        addData() {
            _data++;
            notifyListeners();
        } 

        // use notifyPageState to update the top node，like empty page, fail page, fullscreen loading page
        requestInitData() {
            if (_isInitData) return;
            _isInitData = true;
            Future.delayed(Duration(seconds: 3), () {
            _data++;
            pageViewState.notifyPageState(PageViewStateValue.PageViewLoadedSuccess);
            _isInitData = false;
            });            
        }
    }
```

2, Create class to inherit PageView

```
    class HomePageView<T extends ModelView> extends PageView<T, PageViewState> {

        // override this method to init data
        @override
        initData(BuildContext context) {
            final modelView = getModelView(context, listent: false);
            modelView.requestInitData();
        }        

        // Implement the methods in the pagebuildwidget class to provide the widget to the corresponding page state
        
        @override
        Widget buildInitWidget(BuildContext context) {
            return Container(child: null);
        }

        // after request network success, implement this method to provide the success page widget
        @override
        Widget buildContent(BuildContext context) {
            return Container(child: null);
        } 

        // after request network, if no date , implement this method to provide the empty page widget
        @override
        Widget buildEmptyWidget(BuildContext context) {
            return Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: InkWell(
                onTap: () {
                    emptyRetryCallback(context);
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Expanded(child: Container(
                        width: 405,
                        height: 281,
                        child: Image.asset('images/no_data.png'),
                    )),
                    Expanded(child: Text('Empty Page',style: TextStyle(color: Colors.grey, fontSize: 15),))
                    ],
                ),
                )
            );
        }               

        // after request network, if fail , implement this method to provide the empty page widget
        @override
        Widget buildLoadedFailWidget(BuildContext context) {
            return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: InkWell(
                onTap: () {
                failRetryCallback(context);
                },
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Expanded(child: Container(
                    width: 405,
                    height: 317,
                    child: Image.asset('images/load_error.png'),
                    )),
                    Expanded(child: Text("加载失败，请轻触重试!",style: TextStyle(color: Colors.grey, fontSize: 15),)),
                ],
                ),
            )
            );
        }

        @override
        Widget buildFullScreenLoadingWidget(BuildContext context) {
            return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            color: Colors.white,
            child: Container(
                height: 100,
                padding: EdgeInsets.all(10),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Expanded(child: Container(
                    width: 50,
                    height: 50,
                    // child: Image.asset('images/cargo_loading.gif'),
                    child: CupertinoActivityIndicator(),
                    )),
                    Expanded(child: Text('加载中...',style: TextStyle(color: Colors.grey, fontSize: 15),))]
                ),
            ),
            );
        }

        @override
        emptyRetryCallback(dynamic modelView) {
            
        }

        @override
        failRetryCallback(dynamic modelView) {
            
        }        
    }
    
```

3，use pageviewhelper to create a MultiProvider

```
    // use default page view state value
    var widget = PageViewHelper.createPage(HomeViewModel(1), HomePageView()),

    // change page view state value to PageViewShowFullScreenLoading
    var widget = PageViewHelper.createPage(HomeViewModel(1, pageViewStateValue: PageViewStateValue.PageViewShowFullScreenLoading), HomePageView())

```
