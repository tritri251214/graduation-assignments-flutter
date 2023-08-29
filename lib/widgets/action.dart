import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/utils/snackbar.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:provider/provider.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget(
      {super.key, required this.eventId, this.iconColor = Colors.black});

  final int eventId;
  final Color? iconColor;

  @override
  State<StatefulWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  late EventProvider _eventProvider;
  bool _isLoadingFavorite = false;

  @override
  initState() {
    _eventProvider = context.read<EventProvider>();
    super.initState();
  }

  Future<void> _onPressFavorite() async {
    setState(() {
      _isLoadingFavorite = true;
    });
    try {
      await _eventProvider.favouriteEvent(widget.eventId);
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, const Text('Favourite successfully'), TypeSnackBar.success);
    } catch (_) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, const Text('Favourite failed'), TypeSnackBar.error);
    } finally {
      setState(() {
        _isLoadingFavorite = false;
      });
    }
  }

  Future<void> _onPressUnFavorite() async {
    setState(() {
      _isLoadingFavorite = true;
    });
    try {
      await _eventProvider.unFavouriteEvent(widget.eventId);
      // ignore: use_build_context_synchronously
      showSnackBar(context, const Text('Un favourite successfully'),
          TypeSnackBar.success);
    } catch (_) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, const Text('Un favourite fail'),
          TypeSnackBar.error);
    } finally {
      setState(() {
        _isLoadingFavorite = false;
      });
    }
  }

  Future<void> _onPressShare() async {
    showNeedImplement(context);
  }

  Widget buildIconFavorite(bool statusFavorite) {
    Widget buildContent;
    if (_isLoadingFavorite) {
      buildContent = const LoadingButton();
    } else if (statusFavorite) {
      buildContent = const Icon(Icons.favorite, color: Colors.red);
    } else {
      buildContent = const Icon(Icons.favorite_outline);
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    Event event = context.watch<EventProvider>().getEventById(widget.eventId);
    bool statusFavorite = bool.parse(event.favourite.toString());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: statusFavorite ? _onPressUnFavorite : _onPressFavorite,
          icon: buildIconFavorite(statusFavorite),
          color: widget.iconColor!,
        ),
        IconButton(
            onPressed: _onPressShare,
            icon: const Icon(Icons.share_outlined),
            color: widget.iconColor!),
      ],
    );
  }
}
