import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/colors.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/home/home_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static String routeName = '/favorites';

  const FavoriteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Event> _favouriteData = [];
  bool _isLoading = false;
  late EventProvider _eventProvider;

  @override
  void initState() {
    _eventProvider = context.read<EventProvider>();
    _reload();
    super.initState();
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _eventProvider.getFavouritesEvent();
      setState(() {
        _favouriteData = _eventProvider.favouriteEventData;
      });
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _eventProvider.refreshFavourites();
      setState(() {
        _favouriteData = _eventProvider.favouriteEventData;
      });
    } catch (error) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildEmpty() {
    return const Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite, color: AppColors.backgroundCard, size: 150),
            Text('No favourites yes',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Make sure you have added event’s in this section'),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text('Favourites',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 5),
            SizedBox(
              width: 26,
              height: 26,
              child: Badge.count(
                count: _favouriteData.length,
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: _onRefresh, icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: !_isLoading && _favouriteData.isEmpty
          ? buildEmpty()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(14.0),
              physics: _favouriteData.isEmpty
                  ? const NeverScrollableScrollPhysics()
                  : const ScrollPhysics(),
              child: ListEventsWidget(
                loading: _isLoading,
                eventData: _favouriteData,
                displayLatest: false,
              ),
            ),
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.favorites),
    );
  }
}