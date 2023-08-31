import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/strings.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/empty.dart';
import 'package:graduation_assignments_flutter/widgets/list_events.dart';
import 'package:provider/provider.dart';

enum Sorter { asc, desc }

class SearchEventsScreen extends StatefulWidget {
  static String routeName = '/search-event';

  const SearchEventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventsScreen> {
  late TextEditingController _controller;
  Sorter _sorter = Sorter.asc;
  bool _isLoading = false;
  List<Event> _searchData = [];
  late EventProvider _eventProvider;

  @override
  void initState() {
    _eventProvider = context.read<EventProvider>();
    _onSearch('');
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/empty_data_icon.png'), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSearch(String textSearch) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String sortBy = 'name';
      String sortType = _sorter == Sorter.asc ? 'asc' : 'desc';

      List<Event> events = await _eventProvider.searchEvents(
        textSearch,
        sortBy,
        sortType,
      );
      setState(() {
        _searchData = events;
      });
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onPressedSorter() {
    if (_sorter == Sorter.asc) {
      setState(() {
        _sorter = Sorter.desc;
      });
    } else {
      setState(() {
        _sorter = Sorter.asc;
      });
    }
    _onSearch(_controller.text);
  }

  Widget buildEmpty() {
    return const EmptyWidget(
        title: 'No event yes',
        description: 'Make sure you have added event\'s in this section');
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContent;
    if (!_isLoading && _searchData.isEmpty) {
      buildContent = buildEmpty();
    } else {
      buildContent = SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: ListEventsWidget(loading: _isLoading, eventData: _searchData, displayLatest: false),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
            padding: const EdgeInsets.all(14),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _onSearch,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _onSearch(_controller.text),
                        icon: const Icon(CupertinoIcons.search),
                      ),
                      hintText: 'Search for event name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_searchData.length} Events',
                          style: const TextStyle(fontFamily: AppStrings.rootFont)),
                      TextButton(
                        onPressed: _onPressedSorter,
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('A-Z'), // <-- Text
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                                _sorter == Sorter.asc
                                    ? CupertinoIcons.chevron_down
                                    : CupertinoIcons.chevron_up,
                                size: 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
      body: SafeArea(
        child: buildContent,
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.search),
    );
  }
}
