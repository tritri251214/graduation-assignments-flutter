import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/action.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
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
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

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
      setState(() {
        _event = event;
      });
    } catch (error) {
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
      bool result = await _eventProvider.deleteEvent(widget.eventId);
      if (result) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, const Text('Deleted event successfully!'),
            TypeSnackBar.success);
      }
    } catch (error) {
      // todo
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
      buildContent = const Text('Delete Event');
    }
    return buildContent;
  }

  Widget buildRoot() {
    Widget buildContent;
    const styleTextButton = TextStyle(fontWeight: FontWeight.bold);
    if (_isLoading) {
      buildContent = const LoadingListEvent();
    } else {
      buildContent = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_event.name,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(Icons.calendar_today_outlined, size: 16),
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
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 0)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: AppDimensions.borderButtonRadius,
                        )
                      ),
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
                child: Icon(Icons.location_on_outlined, size: 16),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_event.name, style: textStyleGenerate),
                  const SizedBox(height: 5),
                  if (_event.address != null) Text(_event.address!),
                  TextButton(
                    onPressed: _onPressItem,
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 0)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: AppDimensions.borderButtonRadius,
                        )
                      ),
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
            : Container(
                padding: const EdgeInsets.all(14),
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_event.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => widget.router.goBack(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      child: ActionWidget(eventId: _event.id!),
                    )
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
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
                  child: _isLoading ? const LoadingText() : Text('\$ ${_event.price}'),
                ),
              ],
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 190,
              height: 45,
              child: FilledButton(
                onPressed: _onPressedDeleteEvent,
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(AppColors.dangerColor),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: AppDimensions.borderButtonRadius,
                    )
                  ),
                ),
                child: buildDeleteButton(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
