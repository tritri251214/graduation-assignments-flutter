import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/screen_size.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:provider/provider.dart';

class NewEvent extends StatefulWidget {
  static String routeName = '/new-event';

  const NewEvent({super.key, this.router = const AppRouter()});

  final AppRouter router;

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final Event _event = Event.newEvent();
  bool _isLoading = false;
  late EventProvider eventProvider;
  late Size screenSize = getScreenSize(context);

  @override
  initState() {
    eventProvider = context.read<EventProvider>();
    super.initState();
  }

  Future<void> _onPressSave() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await eventProvider.addEvent(_event);
    } catch (e) {
      // todo
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildButtonSave() {
    Widget buildContent;
    if (_isLoading) {
      buildContent = const LoadingButton();
    } else {
      buildContent = const Text('Submit', style: TextStyle(fontSize: 16));
    }
    return buildContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Event'),
        leading: IconButton(
          onPressed: () => widget.router.goBack(context),
          icon: const Icon(Icons.close_outlined),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _event.name,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.borderInput),
                  ),
                  hintText: 'Name',
                  filled: true,
                  fillColor: AppColors.backgroundInput,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _event.name = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _event.time,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.borderInput),
                  ),
                  hintText: 'Time',
                  filled: true,
                  fillColor: AppColors.backgroundInput,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _event.time = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _event.location,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.borderInput),
                  ),
                  hintText: 'Location',
                  filled: true,
                  fillColor: AppColors.backgroundInput,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _event.location = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _event.location,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.borderInput),
                  ),
                  hintText: 'Price',
                  filled: true,
                  fillColor: AppColors.backgroundInput,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _event.price = value as double;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.1,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.all(14),
          child: SizedBox(
            width: double.infinity,
            height: double.maxFinite,
            child: FilledButton(
              onPressed: _onPressSave,
              child: buildButtonSave(),
            ),
          ),
        ),
      ),
    );
  }
}
