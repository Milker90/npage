[![Build Status](https://travis-ci.org/Milker90/npage.svg?branch=master)](https://travis-ci.org/Milker90/npage)

# npage

npage is a library to implement basic pages. It uses MVVM architecture.

## Installing
```
    dependencies:
        url: git@github.com:Milker90/npage.git
        ref: 1.0.4
```

## Usage

1, Create class to inherit ViewModel
```
    class HomeViewModel extends ViewModel {
        // remember call super, if custom constructor, because ViewModel needs 
        // to create PageViewState instance.
        // finally, when using pageviewhelper to create a MultiProvider, 
        // HomeViewModel and PageViewState will be added at the same time.
        // if want to change page state, call pageViewState.notifyPageState(state), 
        // pageViewState is in top node use Provider, 
        // so If HomeViewModel and PageViewState change at the same time，
        // call only pageViewState.notifyPageState

        HomeViewModel(data, {PageViewStateValue pageViewStateValue}) : 
        _data = data, 
        super(pageViewStateValue: pageViewStateValue);

        int _data;
        List<Model> _modelData;
        bool _isInitData = false;

        // Use notifyListeners to update require specific nodes 
        addData() {
            _data++;
            notifyListeners();
        } 

        // use notifyPageState to update the top node，like empty page, fail page, fullscreen loading page
        requestInitData() {
            if (_isInitData || _modelData != null) return;
            _isInitData = true;
            Future.delayed(Duration(seconds: 3), () {
            _modelData = [];
            pageViewState.notifyPageState(PageViewStateValue.LoadedSuccess);
            _isInitData = false;
            });            
        }
    }
```

2, Create class to inherit PageView

```
    class HomePageView<T extends ModelView> extends PageView<T, PageViewState> {
        // override this method to init data
        // note that initdata method will be called every time flutter calls build method, 
        // so some judgment needs to be added to avoid repeated initialization of data
        @override
        initData(BuildContext context) {
            final modelView = getModelView(context, listent: false);
            modelView.requestInitData();
        }        

        // implement the methods in the pagebuildwidget class to provide the widget 
        // to the corresponding page state 
        
        // the init widget should show in the page
        @override
        Widget buildInitWidget(BuildContext context) {
            return Container(child: null);
        }

        // after request network success, implement this method to provide the success page widget
        @override
        Widget buildContent(BuildContext context) {
            return Container(child: null);
        } 

        // after request network, if no data, implement this method to provide the empty page widget
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
                      Expanded(
                        child: Text('Empty Page',
                        style: TextStyle(color: Colors.grey, fontSize: 15),)
                      )
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
                    Expanded(
                      child: Container(
                        width: 405,
                        height: 317,
                        child: Image.asset('images/load_error.png'),
                    )),
                    Expanded(child: Text("request failed, please retry again",
                    style: TextStyle(color: Colors.grey, fontSize: 15),)),
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
                      child: CupertinoActivityIndicator(),
                    )),
                    Expanded(child: Text('loading...',
                    style: TextStyle(color: Colors.grey, fontSize: 15),))]
                ),
            ),
            );
        }

        @override
        emptyRetryCallback(BuildContext context) {
            
        }

        @override
        failRetryCallback(BuildContext context) {
            
        }        
    }
    
```

3, use pageviewhelper to create a MultiProvider

```
    // use default page view state value
    var widget = PageViewHelper.createPage(HomeViewModel(1), HomePageView());

    // change page view state value to ShowFullScreenLoading
    var widget = PageViewHelper.createPage(HomeViewModel(1,
    pageViewStateValue:PageViewStateValue.ShowFullScreenLoading), 
    HomePageView());

```



## Note
Do not use directly pageviewhelper to create a MultiProvider for a tabbarview widget, 
because in tabbarview, when the page is switched, the ViewModel in the page will be disposed

