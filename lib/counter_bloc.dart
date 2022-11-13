import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputes the date
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposinh only a sin which inputs the data
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // newEvet we want to map to the state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispoase() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
