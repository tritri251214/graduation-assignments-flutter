import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/widgets/action.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/location.dart';
import 'package:graduation_assignments_flutter/widgets/new_badge.dart';

class ListEventsWidget extends StatefulWidget {
  const ListEventsWidget({
    super.key,
    required this.loading,
    required this.eventData,
    this.router = const AppRouter(),
    this.displayLatest = true,
  });

  final bool loading;
  final AppRouter router;
  final List<Event> eventData;
  final bool displayLatest;

  @override
  State<StatefulWidget> createState() => _ListEventsWidgetState();
}

class _ListEventsWidgetState extends State<ListEventsWidget> {
  Widget buildEvent(Event event, bool? isLatest) {
    return Column(children: [
      InkWell(
        onTap: () {
          widget.router.gotoSingleEvent(context, event.id!);
        },
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: (widget.displayLatest && (isLatest != null && isLatest))
                  ? Stack(
                      alignment: const Alignment(1.3, -1.3),
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: AppDimensions.imageListBorderRadius,
                            child:
                                Image.network(event.image, fit: BoxFit.cover),
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
                  Text(event.getFormatTime(),
                      style: const TextStyle(fontSize: 12)),
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
      ),
      const SizedBox(height: 20),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < widget.eventData.length; i++) {
      if (i == 0) {
        children.add(buildEvent(widget.eventData[i], true));
      } else {
        children.add(buildEvent(widget.eventData[i], false));
      }
    }
    return widget.loading
        ? const LoadingListEvent()
        : Column(
            children: children,
          );
  }
}
