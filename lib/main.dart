import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:reduxapp/redux/app_state.dart';
import 'package:reduxapp/redux/middleware.dart';
import 'package:reduxapp/redux/reducers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<AppState>(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

// root widget
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> locations = [];
  List<String> times = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StoreConnector<AppState, FetchTime>(
        converter: (store) => () => store.dispatch(fetchTime),
        builder: (_, fetchTimeCallback) {
          return FloatingActionButton(
            onPressed: fetchTimeCallback,
            child: Icon(Icons.add),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Flutter Redux"),
      ),
      body: Center(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            locations.add(state.location);
            times.add(state.time);

            return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(child: Text(index.toString())),
                      ),
                      Container(
                        color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(child: Text(locations[index])),
                      ),
                      Expanded(
                          child: Container(
                        height: 50,
                        color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                        child: Center(child: Text(times[index])),
                      )),
                    ],
                  );
                });
          },
        ),

        // fetch time button
      ),
    );
  }
}

typedef FetchTime = void Function();
