import 'package:flutter/cupertino.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';

class AppRouter {
  const AppRouter();

  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (_) => const HomeScreen(),
    NewEvent.routeName: (_) => const NewEvent(),
  };

  static CupertinoPageRoute? onGenerateRoute(RouteSettings settings) {
    if (settings.name == SingleEvent.routeName) {
      final args = settings.arguments as SingleEventArguments;
      return CupertinoPageRoute(
        builder: (_) => SingleEvent(eventId: args.eventId)
      );
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  Future<void> gotoNewEvent(
    BuildContext context,
  ) async {
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => const NewEvent()));
  }

  Future<void> goBack(BuildContext context) async {
    Navigator.of(context).pop();
  }

  Future<void> gotoSingleEvent(
    BuildContext context,
    int eventId,
  ) async {
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => SingleEvent(eventId: eventId)));
  }
}
