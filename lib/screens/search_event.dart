import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
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

  @override
  Widget build(BuildContext context) {
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
                        icon: const Icon(Icons.search_outlined),
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
                          style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                    ? Icons.expand_more_outlined
                                    : Icons.expand_less_outlined,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: ListEventsWidget(
              loading: _isLoading, eventData: _searchData, displayLatest: false),
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.search),
    );
  }
}
