import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/widgets/action.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/new_badge.dart';
import 'package:provider/provider.dart';

class LatestEventWidget extends StatelessWidget {
  const LatestEventWidget({
    super.key,
    required this.loading,
    this.router = const AppRouter(),
  });

  final bool loading;
  final AppRouter router;

  Widget buildRoot(BuildContext context) {
    Widget buildContent;
    if (loading) {
      buildContent = const LoadingLatestEvent();
    } else {
      buildContent = Consumer<EventProvider>(
        builder: (_, provider, __) => InkWell(
          onTap: () {
            router.gotoSingleEvent(context, provider.latestEvent!.id!);
          },
          child: Card(
            margin: const EdgeInsets.all(0),
            color: AppColors.backgroundCard,
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.cardBorderRadius,
            ),
            elevation: 2.0,
            child: Column(
              children: [
                Stack(
                  alignment: const Alignment(0.95, -0.8),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 150.0,
                      child: ClipRRect(
                        borderRadius: AppDimensions.imageCardBorderRadius,
                        child: CachedNetworkImage(
                          imageUrl: provider.latestEvent!.image,
                          imageBuilder: (_, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (_, __) => const LoadingImage(width: double.infinity, height: double.infinity),
                          errorWidget: (_, __, ___) => const Icon(Icons.image_outlined, color: AppColors.dangerColor, size: 40),
                        ),
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 16),
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
                        ActionWidget(eventId: provider.latestEvent!.id!),
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const LoadingLatestEvent() : buildRoot(context);
  }
}
