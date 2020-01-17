import 'package:flutter/material.dart';
import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class AppComponentMock extends Mock implements AppComponent {}

class CounterInteractorMock extends Mock implements CounterInteractor {}

CounterInteractorMock getCounterInteractor() {
  var mock = CounterInteractorMock();

  when(mock.counterObservable)
      .thenAnswer((_) => Observable<Counter>.just(Counter(111)));

  return mock;
}

AppComponentMock getAppComponent() {
  var mock = AppComponentMock();

  when(mock.counterInteractor).thenAnswer((_) => getCounterInteractor());

  return mock;
}

void main() {
  setUp(() {});

  tearDown(() {});

  testWidgets('find widgets', (WidgetTester tester) async {
    var appComponent = getAppComponent();
    await tester.pumpWidget(
      Injector<AppComponent>(
        component: appComponent,
        builder: (context) {
          return MaterialApp(
            home: WelcomeScreen(),
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    verify(appComponent.counterInteractor).called(1);
  });
}