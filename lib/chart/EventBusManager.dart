
import 'package:event_bus/event_bus.dart';

class EventBusManager {

  static EventBusManager _instance;

  static EventBusManager _getInstance() {
    if (_instance == null) {
      _instance = EventBusManager._internal();
    }
    return _instance;
  }

  static EventBusManager get instance => _getInstance();

  void create() {
    bus = EventBus();
  }

  EventBus bus;

  EventBusManager._internal();

}

