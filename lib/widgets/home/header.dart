import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/screens/screens.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.widget,
    required this.loading,
  });

  final HomeScreen widget;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find events in',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.placeholderText,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16),
                SizedBox(width: 5),
                Text(
                  'Viet Nam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
