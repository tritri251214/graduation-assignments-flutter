import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/constants.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';
// import 'package:provider/provider.dart';

// void main() => runApp(MultiProvider(
//   providers: [
//     ChangeNotifierProvider(create: (_) => TodoProvider()),
//   ],
//   child: const MainApp(),
// ));

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      initialRoute: HomeScreen.routeName,
      routes: AppRouter.routes,
      onGenerateRoute: (settings) {
        // TODO
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
