import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/strings.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/empty.dart';
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

  @override
  void initState() {
    initialization();
    super.initState();

    _eventProvider = context.read<EventProvider>();
    _reload();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/empty_data_icon.png'), context);
    super.didChangeDependencies();
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
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildEmpty() {
    return const EmptyWidget(
        title: 'No event yes',
        description: 'Make sure you have added event\'s in this section');
  }

  @override
  Widget build(BuildContext context) {
    final List<Event> eventData = context.watch<EventProvider>().eventData;

    Widget buildListEventContent;
    if (!_isLoading && eventData.isEmpty) {
      buildListEventContent = buildEmpty();
    } else {
      buildListEventContent = ListEventsWidget(
          loading: _isLoading, eventData: eventData, displayLatest: false);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          physics: _isLoading
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(height: 16),
              const Text('Popular in Viet Nam', style: TextStyle(fontFamily: AppStrings.rootFont, fontSize: 16)),
              const SizedBox(height: 16),
              const LatestEventWidget(),
              const SizedBox(height: 16),
              buildListEventContent,
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.home),
    );
  }
}
