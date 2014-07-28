library main;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import "custom_history.dart";

part "carousel.dart";

void CarouselRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
      'carousel': ngRoute(
          path: '/carousel/:section/:id',
          view: 'carousel.html'),
      'carousel_default': ngRoute(
          defaultRoute: true,
          enter: (RouteEnterEvent e) => router.go('carousel', {"section": "humor", "id": "0"})
      )
  });
}

class MyAppModule extends Module {
  MyAppModule() {
    print("Creation of MyAppModule");
    type(Carousel);
    type(CarouselElement);
    value(RouteInitializerFn, CarouselRouteInitializer);
    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));
  }
}

void main() {
  applicationFactory()
  .addModule(new MyAppModule())
  .run();
}
