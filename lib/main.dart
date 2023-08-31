import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/common/storage.dart';
import 'package:graduation_assignments_flutter/providers/providers.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  await AppStorage.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EventProvider()),
      ChangeNotifierProvider(create: (_) => TicketProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/empty_data_icon.png'), context);

    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        fontFamily: 'HelveticaNeue',
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(AppColors.primaryColor)),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: AppRouter.routes,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
