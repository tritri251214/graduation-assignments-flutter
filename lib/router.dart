import 'package:flutter/cupertino.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';

class AppRouter {
  const AppRouter();

  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (_) => const HomeScreen(),
    NewEvent.routeName: (_) => const NewEvent(),
  };

  Future<void> gotoNewEvent(
    BuildContext context,
  ) async {
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => const NewEvent()));
  }

  Future<void> goBack(BuildContext context) async {
    Navigator.of(context).pop();
  }
}
