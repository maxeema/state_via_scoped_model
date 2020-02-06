import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

void main() {
  runApp(MyApp(
    model: Counter(),
  ));
}

class MyApp extends StatelessWidget {
  final Counter model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Counter>(
      model: model,
      child: MaterialApp(
        title: 'State - Scoped Model Demo',
        home: CounterHome('Scoped Model Demo'),
      ),
    );
  }
}

class CounterHome extends StatelessWidget {
  final String title;

  CounterHome(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: CounterLabel(),
      ),
      floatingActionButton: IncrementCounterFab(),
    );
  }
}

class CounterLabel extends StatelessWidget {
  const CounterLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('You have pushed the button this many times:'),
        ScopedModelDescendant<Counter>(
          builder: (context, child, model) =>
            Text(
              model.counter.toString(),
              style: Theme.of(context).textTheme.display1,
            )
        ),
      ],
    );
  }
}

class IncrementCounterFab extends StatelessWidget {
  const IncrementCounterFab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return FloatingActionButton(
        onPressed: ScopedModel.of<Counter>(context, rebuildOnChange: false).increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    }
}