import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/screen_size.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/action.dart';
import 'package:graduation_assignments_flutter/widgets/load_image.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:graduation_assignments_flutter/widgets/null_text.dart';
import 'package:provider/provider.dart';

class SingleEventArguments {
  final int eventId;

  const SingleEventArguments({required this.eventId});
}

class SingleEvent extends StatefulWidget {
  static String routeName = '/single-event';

  const SingleEvent(
      {super.key, required this.eventId, this.router = const AppRouter()});

  final int eventId;
  final AppRouter router;

  @override
  State<StatefulWidget> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  late Event _event;
  bool _isLoading = true;
  bool _isLoadingDelete = false;
  late EventProvider _eventProvider;
  static const textStyleGenerate =
      TextStyle(fontFamily: AppStrings.rootFont, fontSize: 16);
  late Size screenSize = getScreenSize(context);
  bool isLatestEvent = false;

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
      Event event = await _eventProvider.getEvent(widget.eventId);
      Event? lastestEvent = _eventProvider.latestEvent;
      if (lastestEvent != null && lastestEvent.id == event.id) {
        setState(() {
          _event = event;
          isLatestEvent = true;
        });
      } else {
        setState(() {
          _event = event;
        });
      }
    } catch (_) {
      setState(() {
        _event = Event.newEvent();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onPressItem() {
    showNeedImplement(context);
  }

  Future<void> _onPressedDeleteEvent() async {
    setState(() {
      _isLoadingDelete = true;
    });
    try {
      bool result = await _eventProvider.deleteEvent(widget.eventId, isLatestEvent);
      if (result) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, const Text('Deleted event successfully'),
            TypeSnackBar.success);
      }
      // ignore: use_build_context_synchronously
      widget.router.goBack(context);
    } catch (_) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, const Text('Deleted event fail'), TypeSnackBar.error);
    } finally {
      setState(() {
        _isLoadingDelete = false;
      });
    }
  }

  Widget buildDeleteButton() {
    Widget buildContent;
    if (_isLoadingDelete) {
      buildContent = const LoadingButton();
    } else {
      buildContent = const Text('Delete Event', style: TextStyle(fontFamily: AppStrings.rootFont));
    }
    return buildContent;
  }

  Widget buildRoot() {
    Widget buildContent;
    const styleTextButton = TextStyle(fontFamily: AppStrings.rootFont);
    if (_isLoading) {
      buildContent = const LoadingListEvent();
    } else {
      buildContent = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_event.name,
              style:
                  const TextStyle(fontFamily: AppStrings.rootFont, fontSize: 24)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(CupertinoIcons.calendar, size: 16),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_event.getFormatTime(), style: textStyleGenerate),
                  const SizedBox(height: 5),
                  Text(_event.getFromToTime()),
                  TextButton(
                    onPressed: _onPressItem,
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.only(left: 0)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: AppDimensions.borderButtonRadius,
                      )),
                    ),
                    child:
                        const Text('Add to calendar', style: styleTextButton),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(CupertinoIcons.location, size: 16),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_event.name, style: textStyleGenerate),
                  const SizedBox(height: 5),
                  NullText(text: _event.address!),
                  TextButton(
                    onPressed: _onPressItem,
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.only(left: 0)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: AppDimensions.borderButtonRadius,
                      )),
                    ),
                    child: const Text('View on maps', style: styleTextButton),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text('About', style: textStyleGenerate),
          const SizedBox(height: 10),
          const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
        ],
      );
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: _isLoading
            ? const LoadingImage()
            : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: LoadImage(imageUrl: _event.image, borderRadius: BorderRadius.zero),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => widget.router.goBack(context),
                          icon: const Icon(CupertinoIcons.chevron_back),
                        ),
                        SizedBox(
                          child: ActionWidget(eventId: _event.id!),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: buildRoot(),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenSize.height * 0.13,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price', style: textStyleGenerate),
                  const SizedBox(height: 5),
                  Expanded(
                    child: _isLoading
                        ? const LoadingText()
                        : Text('\$ ${_event.price}'),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 190,
                height: double.maxFinite,
                child: FilledButton(
                  onPressed: _onPressedDeleteEvent,
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(AppColors.dangerColor),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: AppDimensions.borderButtonRadius,
                    )),
                  ),
                  child: buildDeleteButton(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
