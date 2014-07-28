import 'dart:html';
import 'dart:async';

class StateEvent {
  Object data;
  String title;
  String url;

  StateEvent(this.data, this.title, [this.url]);
}

class CustomHistory {
  StreamController<StateEvent> _onPushStateEvent;
  Stream onPushStateEvent;
  StreamController<StateEvent> _onReplaceStateEvent;
  Stream onReplaceStateEvent;


  CustomHistory() {
    this._onPushStateEvent = new StreamController();
    this.onPushStateEvent = this._onPushStateEvent.stream;

    this._onReplaceStateEvent = new StreamController();
    this.onReplaceStateEvent = this._onReplaceStateEvent.stream;
  }

  void back() {
    window.history.back();
  }

  void forward() {
    window.history.forward();
  }

  void go(int distance) {
    window.history.go(distance);
  }

  void pushState(Object data, String title, [String url]) {
    window.history.pushState(data, title, url);
    this._onPushStateEvent.add(new StateEvent(data, title, url));
  }

  void replaceState(Object data, String title, [String url]) {
    window.history.replaceState(data, title, url);
    this._onReplaceStateEvent.add(new StateEvent(data, title, url));
  }

}

CustomHistory history = new CustomHistory();
