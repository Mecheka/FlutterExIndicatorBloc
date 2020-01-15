import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:state_manage/bloc/indicarot_bloc.dart';
import 'package:state_manage/bloc/indicator_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => IndicatorBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final selectList = [true, false, false, false, false];
  final itemKey = {};
  final listViewKey = RectGetter.createGlobalKey();
  final headerKey = RectGetter.createGlobalKey();
  int oldPositionSelected = 0;

  @override
  Widget build(BuildContext context) {
    final IndicatorBloc indicatorBloc = BlocProvider.of<IndicatorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('State manage'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: NotificationListener(
                onNotification: (noti) {
                  print(getVisible());
                  int visibleIndex = getVisible().first;
                  print('visible index ;' + visibleIndex.toString());
                  indicatorBloc.add(UpdateIndicator(index: visibleIndex));
                  return true;
                },
                child: RectGetter(
                  key: listViewKey,
                  child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      itemKey[index] = RectGetter.createGlobalKey();
                      return RectGetter(
                        key: itemKey[index],
                        child: Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height - 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text('$index'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<IndicatorBloc, List<bool>>(
                bloc: indicatorBloc,
                builder: (BuildContext context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(state);
                      return AnimatedContainer(
                        height: state[index] ? 46 : 6,
                        width: 6,
                        duration: Duration(milliseconds: 500),
                        color: state[index] ? Colors.red : Colors.blue,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 4,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<int> getVisible() {
    /// First, get the rect of ListView, and then traver the _keys
    /// get rect of each item by keys in _keys, and if this rect in the range of ListView's rect,
    /// add the index into result list.
    var rect = RectGetter.getRectFromKey(listViewKey);
    var headerRect = RectGetter.getRectFromKey(headerKey);
    var _items = <int>[];
    itemKey.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null &&
          !(itemRect.top > rect.bottom || itemRect.bottom - 120 < rect.top))
        _items.add(index);
    });

    /// so all visible item's index are in this _items.
    return _items;
  }
}
