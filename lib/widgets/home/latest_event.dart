import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/widgets/home/home_widget.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/new_badge.dart';
import 'package:provider/provider.dart';

class LatestEventWidget extends StatelessWidget {
  const LatestEventWidget({
    super.key,
    required this.loading,
  });

  final bool loading;

  Widget buildRoot(BuildContext context) {
    Widget widget;
    if (loading) {
      widget = const LoadingLatestEvent();
    } else {
      widget = Card(
        margin: const EdgeInsets.all(0),
        color: AppDimensions.backgroundCard,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.cardBorderRadius,
        ),
        elevation: 2.0,
        child: Consumer<EventProvider>(
          builder: (_, provider, __) => Column(
            children: [
              Stack(
                alignment: const Alignment(0.95, -0.8),
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: ClipRRect(
                      borderRadius: AppDimensions.imageCardBorderRadius,
                      child: Image.network(provider.latestEvent!.image, fit: BoxFit.cover),
                    ),
                  ),
                  const NewBadgeWidget(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.latestEvent!.getFormatTime(),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.latestEvent!.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                provider.latestEvent!.location,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ActionWidget(eventId: provider.latestEvent!.id),
                    ]),
              ),
            ],
          ),
        ),
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return buildRoot(context);
  }
}