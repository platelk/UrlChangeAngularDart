part of main;

Map<String, List<String>> _sentences = {
    "humor": [
        "I found there was only one way to look thin: hang out with fat people.",
        "My fake plants died because I did not pretend to water them.",
        "Go to Heaven for the climate, Hell for the company."
    ], "serious": [
        "Love is a serious mental disease.",
        "A joke is a very serious thing.",
        "Do the best you can, and don't take life too serious."
    ], "programming": [
        "Talk is cheap. Show me the code.",
        "You've baked a really lovely cake, but then you've used dog shit for frosting.",
        "Programs must be written for people to read, and only incidentally for machines to execute."
    ]};

@Component(
    selector: 'carousel-element',
    templateUrl: 'component/CarouselElement/carousel_element.html',
    cssUrl: 'component/CarouselElement/carousel_element.css',
    publishAs: 'cmp',
    useShadowDom: false
)
class CarouselElement {
  RouteProvider _routeProvider;
  Router _router;
  String text;
  String section;
  int id;

  CarouselElement(this._routeProvider, this._router) {
    print("Creating carousel element");
    this.section = this._routeProvider.parameters["section"];
    this.id = int.parse(this._routeProvider.parameters["id"]);
    this.text = this.getText();

    print(window.history.length);
    window.onHashChange.listen((e) => print(e));
    history.onPushStateEvent.listen((e) {
      print("List on PopState");
      print(e.url.split("/"));
      var l = e.url.split("/");
      this.section = l[2];
      this.id = int.parse(l[3]);
      this.text = getText();
    });
  }

  String getText() {
    if (this.id >= _sentences[this.section].length) {
      this.id = _sentences[this.section].length - 1;
    } else if (this.id < 0) {
      this.id = 0;
    }
    return _sentences[this.section][this.id];
  }

  void goPrev() {
    print("On prev called");
    this.id--;
    this.text = this.getText();
    changeImg();
  }

  void goNext() {
    print("On next called");
    this.id++;
    this.text = this.getText();
    changeImg();
  }

  void changeImg() {
    history.pushState(null, "Img", "#/carousel/${this.section}/${this.id}");
  }
}

@Controller(
    selector: '[carousel]',
    publishAs: 'ctrl')
class Carousel {
  RouteProvider _routeProvider;
  String section;

  Carousel(this._routeProvider) {
    window.onHashChange.listen((e) => print('event : ${e}'));
    section = this._routeProvider.parameters["section"];
    print("Carousel Creation, ${this.section}");
  }

  void nextSection() {
      var keys = _sentences.keys.toList();
      var i = keys.indexOf(this.section);
      if (i == keys.length-1) {
        i = 0;
      } else {
        i++;
      }
    this.section = keys[i];
      changeSection();
  }

  void prevSection() {
    var keys = _sentences.keys.toList();
    var i = keys.indexOf(this.section);
    if (i == 0) {
      i = keys.length-1;
    } else {
      i--;
    }
    this.section = keys[i];
    changeSection();
  }

  void changeSection() {
    history.pushState(null, "Img", "#/carousel/${this.section}/0");
  }
}