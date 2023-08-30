import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/null_text.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, this.router = const AppRouter()});

  final AppRouter router;

  @override
  State<StatefulWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  Placemark _location = Placemark();

  @override
  void initState() {
    _reload();
    super.initState();
  }

  Future<void> _reload() async {
    try {
      bool isCallDeterminePosition = await beforeDeterminePosition();
      if (isCallDeterminePosition) {
        Position position = await determinePosition();
        List<Placemark> placemarks =
            await placemarkFromCoordinates(position.latitude, position.longitude);
        setState(() {
          _location = placemarks[0];
        });
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, Text(error.toString()), TypeSnackBar.warning);
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
                NullText(text: _location.country, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
