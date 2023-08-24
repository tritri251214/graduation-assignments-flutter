import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/utils/snackbar.dart';
import 'package:provider/provider.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget({super.key, required this.eventId});

  final int eventId;

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
      await _eventProvider.favoriteEvent(widget.eventId);
      // ignore: use_build_context_synchronously
      showSnackBar(context, const Text('Favorite successfully'), TypeSnackBar.success);
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
      await _eventProvider.unFavoriteEvent(widget.eventId);
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
    showSnackBar(
        context, const Text('This future not implement'), TypeSnackBar.warning);
  }

  Widget buildIconFavorite() {
    Widget widget;
    if (_isLoadingFavorite) {
      widget = Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2.0),
        child: const CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 3,
        ),
      );
    } else if (_statusFavorite) {
      widget = const Icon(Icons.favorite, color: Colors.red);
    } else {
      widget = const Icon(Icons.favorite_outline);
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _statusFavorite ? _onPressUnFavorite : _onPressFavorite,
          icon: buildIconFavorite(),
        ),
        IconButton(
          onPressed: _onPressShare,
          icon: const Icon(Icons.share_outlined),
        ),
      ],
    );
  }
}
