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
  late bool _statusFavorite = false;

  @override
  initState() {
    super.initState();
    _eventProvider = context.read<EventProvider>();
    _reload();
  }

  void _reload() {
    Event event = _eventProvider.getEventById(widget.eventId);
    setState(() {
      _statusFavorite = event.favorite as bool;
    });
  }

  Future<void> _onPressFavorite() async {
    setState(() {
      _isLoadingFavorite = true;
    });
    try {
      Event event = await _eventProvider.favoriteEvent(widget.eventId);
      setState(() {
        _statusFavorite = event.favorite as bool;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, const Text('Favorite successfully'), TypeSnackBar.success);
    } catch (e) {
      // todo
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
      Event event = await _eventProvider.unFavoriteEvent(widget.eventId);
      setState(() {
        _statusFavorite = event.favorite as bool;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context, const Text('Un favorite successfully'),
          TypeSnackBar.success);
    } catch (e) {
      // todo
    } finally {
      setState(() {
        _isLoadingFavorite = false;
      });
    }
  }

  Future<void> _onPressShare() async {
    showNeedImplement(context);
  }

  Widget buildIconFavorite() {
    Widget buildContent;
    if (_isLoadingFavorite) {
      buildContent = const LoadingButton();
    } else if (_statusFavorite) {
      buildContent = const Icon(Icons.favorite, color: Colors.red);
    } else {
      buildContent = const Icon(Icons.favorite_outline);
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _statusFavorite ? _onPressUnFavorite : _onPressFavorite,
          icon: buildIconFavorite(),
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
