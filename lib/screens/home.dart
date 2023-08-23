import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/constants.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({super.key, this.router = const AppRouter()});

  final AppRouter router;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find events in',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.placeholderText,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'Viet Nam',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FilledButton(
                    onPressed: () => widget.router.gotoNewEvent(context),
                    child: const Text('New Event')
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Popular in Viet Nam', style: TextStyle(fontSize: 16, color: AppColors.placeholderText)),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: AppDimensions.cardBorderRadius,
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 120.0,
                        child: ClipRRect(
                          borderRadius: AppDimensions.imageCardBorderRadius,
                          child: Image.network('https://picsum.photos/200', fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mon, Apr 18 - 21:00 pm', style: TextStyle(fontSize: 14),),
                        SizedBox(height: 8),
                        Text('Tri Nguyen Minh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 16),
                            SizedBox(width: 5),
                            Text(
                              'Viet Nam',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
