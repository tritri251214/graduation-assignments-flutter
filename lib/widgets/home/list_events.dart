import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/home/home_widget.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/location.dart';
import 'package:graduation_assignments_flutter/widgets/new_badge.dart';
import 'package:provider/provider.dart';

class ListEventsWidget extends StatelessWidget {
  const ListEventsWidget({
    super.key,
    required this.loading,
  });

  final bool loading;

  Widget buildEvent(Event event, bool? isLatest) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: (isLatest != null && isLatest)
                  ? Stack(
                      alignment: const Alignment(1.3, -1.3),
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: AppDimensions.imageListBorderRadius,
                            child: Image.network(event.image, fit: BoxFit.cover),
                          ),
                        ),
                        const NewBadgeWidget(),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: AppDimensions.imageListBorderRadius,
                      child: Image.network(event.image, fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.getFormatTime(), style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(event.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(height: 16),
                  LocationWidget(text: event.location),
                ],
              ),
            ),
            const SizedBox(width: 5),
            ActionWidget(eventId: event.id as int),
          ],
        ),
        const SizedBox(height: 20),
      ]
    );
  }

  Widget buildRoot(BuildContext context, EventProvider provider) {
    Widget widget;
    if (loading) {
      widget = const LoadingListEvent();
    } else {
      final children = <Widget>[];
      for (var i = 0; i < provider.eventData.length; i++) {
        if (i == 0) {
          children.add(buildEvent(provider.eventData[i], true));
        } else {
          children.add(buildEvent(provider.eventData[i], false));
        }
      }
      widget = Column(
        children: children,
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (_, provider, __) => buildRoot(context, provider),
    );
  }
}