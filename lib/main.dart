import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/constants.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:provider/provider.dart';

// void main() => runApp(MultiProvider(
//   providers: [
//     ChangeNotifierProvider(create: (_) => TodoProvider()),
//   ],
//   child: const MainApp(),
// ));

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      initialRoute: HomeScreen.routeName,
      routes: AppRouter.routes,
    );
  }
}
