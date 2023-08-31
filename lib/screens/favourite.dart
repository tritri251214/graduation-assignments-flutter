import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/colors.dart';
import 'package:graduation_assignments_flutter/common/strings.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/home/home_widget.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static String routeName = '/favorites';

  const FavoriteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
            Icon(CupertinoIcons.heart_fill, color: AppColors.backgroundCard, size: 150),
            Text('No favourites yes',
                style: TextStyle(fontFamily: AppStrings.rootFont)),
            Text('Make sure you have added event’s in this section'),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Event> favouriteData = context.watch<EventProvider>().favouriteEventData;

    Widget buildContent;
    if (!_isLoading && favouriteData.isEmpty) {
      buildContent = buildEmpty();
    } else {
      buildContent = SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        physics: favouriteData.isEmpty
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        child: ListEventsWidget(
          loading: _isLoading,
          eventData: favouriteData,
          displayLatest: false,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text('Favourites', style: TextStyle(fontFamily: AppStrings.rootFont, fontSize: 24)),
            const SizedBox(width: 5),
            SizedBox(
              width: 26,
              height: 26,
              child: _isLoading ? const LoadingText(width: double.maxFinite, height: double.maxFinite,) : Badge.count(
                count: favouriteData.length,
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: _onRefresh, icon: const Icon(CupertinoIcons.refresh))
        ],
      ),
      body: buildContent,
      bottomNavigationBar:
          const BottomNavigationBarWidget(selectedMenu: Menu.favorites),
    );
  }
}
