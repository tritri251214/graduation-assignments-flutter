import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/home/home_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({super.key, this.router = const AppRouter()});

  final AppRouter router;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EventProvider _eventProvider;
  bool _isLoading = false;
  List<Event> _eventData = [];

  @override
  void initState() {
    initialization();
    super.initState();

    _eventProvider = context.read<EventProvider>();
    _reload();
  }

  @override
  void dispose() {
    _isLoading = false;

    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _eventProvider.getListEvent();
      setState(() {
        _eventData = _eventProvider.eventData;
      });
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
            HeaderWidget(widget: widget, loading: _isLoading),
            const SizedBox(height: 16),
            const Text('Popular in Viet Nam', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            LatestEventWidget(loading: _isLoading),
            const SizedBox(height: 16),
            ListEventsWidget(loading: _isLoading, eventData: _eventData),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.home),
    );
  }
}
