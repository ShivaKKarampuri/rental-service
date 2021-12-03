import 'package:rent_app/login.dart';
import 'package:rent_app/screens/calendar_page.dart';
import 'package:rent_app/screens/main_page.dart';
import 'package:rent_app/screens/settings_page.dart';
import 'package:rent_app/searchpage.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<Object> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<MainPage>(() => MainPage());
   // register<CalendarPage>(() => CalendarPage());
    //register<SettingsPage>(() => SettingsPage());
  }

  static dynamic fromString(String type) {
    return _constructors![type]!();
  }
}