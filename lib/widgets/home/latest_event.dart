import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/widgets/action.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/new_badge.dart';
import 'package:graduation_assignments_flutter/widgets/null_text.dart';
import 'package:provider/provider.dart';

class LatestEventWidget extends StatefulWidget {
  const LatestEventWidget({
    super.key,
    this.router = const AppRouter(),
  });

  final AppRouter router;

  @override
  State<StatefulWidget> createState() => _LatestEventWidgetState();
}

class _LatestEventWidgetState extends State<LatestEventWidget> {
  late EventProvider _eventProvider;
  bool _isLoading = false;

  @override
  void initState() {
    _eventProvider = context.read<EventProvider>();
    _reload();
    super.initState();
  }

  Future<void> _reload() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _eventProvider.getLatestEvent();
    } catch (_) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildRoot(BuildContext context) {
    Event? latestEvent = context.watch<EventProvider>().latestEvent;
    Widget buildContent;
    if (latestEvent == null) {
      buildContent = Card(
        margin: const EdgeInsets.all(0),
        color: AppColors.backgroundCard,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.cardBorderRadius,
        ),
        child: Column(
          children: [
            Stack(
              alignment: const Alignment(0.95, -0.8),
              children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                    border: Border.all(color: AppColors.dangerColor),
                    color: AppColors.dangerColor,
                  ),
                  child: const Image(image: AssetImage('assets/images/empty_data_icon.png')),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NullText(
                        text: '',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(CupertinoIcons.placemark, size: 16),
                          SizedBox(width: 5),
                          NullText(
                            text: '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      buildContent = InkWell(
        onTap: () {
          widget.router.gotoSingleEvent(context, latestEvent.id!);
        },
        child: Card(
          margin: const EdgeInsets.all(0),
          color: AppColors.backgroundCard,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.cardBorderRadius,
          ),
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
                        imageUrl: latestEvent.getImageUrl(),
                        imageBuilder: (_, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (_, __) => const LoadingImage(
                            width: double.infinity, height: double.infinity),
                        errorWidget: (_, __, ___) => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                            border: Border.all(color: AppColors.dangerColor),
                            color: AppColors.dangerColor,
                          ),
                          child: const Image(image: AssetImage('assets/images/empty_data_icon.png')),
                        ),
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
                          NullText(
                              text: latestEvent.getFormatTime(),
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(CupertinoIcons.placemark, size: 16),
                              const SizedBox(width: 5),
                              NullText(
                                  text: latestEvent.location,
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      ActionWidget(eventId: latestEvent.id!),
                    ]),
              ),
            ],
          ),
        ),
      );
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const LoadingLatestEvent() : buildRoot(context);
  }
}
