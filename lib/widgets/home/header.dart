import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, this.router = const AppRouter()});

  final AppRouter router;

  @override
  State<StatefulWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late Placemark _location;
  bool _isLoading = false;

  @override
  void initState() {
    _reload();
    super.initState();
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _location = placemarks[0];
      });
    } catch (_) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find events in',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.placeholderText,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 5),
                if (_isLoading)
                  const LoadingText()
                else
                  Text(_location.country ?? 'Viet Nam', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FilledButton(
              onPressed: () => widget.router.gotoNewEvent(context),
              child: const Text('New Event')),
        ),
      ],
    );
  }
}
