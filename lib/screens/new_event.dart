import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/models/event.dart';
import 'package:graduation_assignments_flutter/providers/event_provider.dart';
import 'package:graduation_assignments_flutter/router.dart';
import 'package:graduation_assignments_flutter/utils/screen_size.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';
import 'package:provider/provider.dart';

enum TypeTextField {
  image,
  name,
  time,
  date,
  location,
  address,
  price,
  timeEnd,
  dateEnd
}

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
  final _formKey = GlobalKey<FormState>();

  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTimeEnd = TimeOfDay.now();
  DateTime _selectedDateEnd = DateTime.now();

  late TextEditingController _controllerImage;
  late TextEditingController _controllerName;
  late TextEditingController _controllerTime;
  late TextEditingController _controllerDate;
  late TextEditingController _controllerLocation;
  late TextEditingController _controllerPrice;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerTimeEnd;
  late TextEditingController _controllerDateEnd;

  @override
  initState() {
    eventProvider = context.read<EventProvider>();
    _controllerImage = TextEditingController(text: _event.image);
    _controllerName = TextEditingController(text: _event.name);
    _controllerTime = TextEditingController(
        text: customFormatTime(
            DateTime.now().toIso8601String(), AppStrings.formatTime));
    _controllerDate = TextEditingController(
        text: customFormatTime(
            DateTime.now().toIso8601String(), AppStrings.formatDate));
    _controllerLocation = TextEditingController(text: _event.location);
    _controllerPrice = TextEditingController(text: _event.price.toString());
    _controllerAddress = TextEditingController(text: _event.address);
    _controllerTimeEnd = TextEditingController(
        text: customFormatTime(
            DateTime.now().toIso8601String(), AppStrings.formatTime));
    _controllerDateEnd = TextEditingController(
        text: customFormatTime(
            DateTime.now().toIso8601String(), AppStrings.formatDate));

    _controllerImage.addListener(() => _onChangeTextField(TypeTextField.image));
    _controllerName.addListener(() => _onChangeTextField(TypeTextField.name));
    _controllerTime.addListener(() => _onChangeTextField(TypeTextField.time));
    _controllerDate.addListener(() => _onChangeTextField(TypeTextField.date));
    _controllerLocation
        .addListener(() => _onChangeTextField(TypeTextField.location));
    _controllerPrice.addListener(() => _onChangeTextField(TypeTextField.price));
    _controllerAddress
        .addListener(() => _onChangeTextField(TypeTextField.address));
    _controllerTimeEnd
        .addListener(() => _onChangeTextField(TypeTextField.timeEnd));
    _controllerDateEnd
        .addListener(() => _onChangeTextField(TypeTextField.dateEnd));

    DateTime eventTime = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    _event.time = eventTime.toIso8601String();
    DateTime eventTimeEnd = DateTime(
        _selectedDateEnd.year,
        _selectedDateEnd.month,
        _selectedDateEnd.day,
        _selectedTimeEnd.hour,
        _selectedTimeEnd.minute);
    _event.timeEnd = eventTimeEnd.toIso8601String();

    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerTime.dispose();
    _controllerDate.dispose();
    _controllerLocation.dispose();
    _controllerPrice.dispose();
    _controllerAddress.dispose();
    _controllerTimeEnd.dispose();
    _controllerDateEnd.dispose();
    super.dispose();
  }

  void _onPressSave() {
    if (_formKey.currentState!.validate()) {
      _onSubmit();
    }
  }

  _onChangeTextField(TypeTextField type) {
    switch (type) {
      case TypeTextField.image:
        _event.image = _controllerImage.text;
        break;
      case TypeTextField.name:
        _event.name = _controllerName.text;
        break;
      case TypeTextField.location:
        _event.location = _controllerLocation.text;
        break;
      case TypeTextField.address:
        _event.address = _controllerAddress.text;
        break;
      case TypeTextField.price:
        _event.price = double.parse(_controllerPrice.text);
        break;
      case TypeTextField.time:
        DateTime eventTime = DateTime(_selectedDate.year, _selectedDate.month,
            _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
        _event.time = eventTime.toIso8601String();
        break;
      case TypeTextField.date:
        DateTime eventTime = DateTime(_selectedDate.year, _selectedDate.month,
            _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
        _event.time = eventTime.toIso8601String();
        break;
      case TypeTextField.timeEnd:
        DateTime eventTimeEnd = DateTime(
            _selectedDateEnd.year,
            _selectedDateEnd.month,
            _selectedDateEnd.day,
            _selectedTimeEnd.hour,
            _selectedTimeEnd.minute);
        _event.timeEnd = eventTimeEnd.toIso8601String();
        break;
      case TypeTextField.dateEnd:
        DateTime eventTimeEnd = DateTime(
            _selectedDateEnd.year,
            _selectedDateEnd.month,
            _selectedDateEnd.day,
            _selectedTimeEnd.hour,
            _selectedTimeEnd.minute);
        _event.timeEnd = eventTimeEnd.toIso8601String();
        break;
      default:
    }
  }

  Future<void> _onSubmit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Event event = await eventProvider.addEvent(_event);
      if (event.id != null) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, const Text('Create event successfully'),
            TypeSnackBar.success);
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context, const Text('Create event failed'), TypeSnackBar.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSelectTime(BuildContext context) async {
    // ignore: use_build_context_synchronously
    final TimeOfDay? timePicker = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (timePicker != null) {
      _selectedTime = timePicker;
      // ignore: use_build_context_synchronously
      _controllerTime.text = timePicker.format(context);
    }
  }

  void _onSelectDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (datePicked != null) {
      _selectedDate = datePicked;
      _controllerDate.text =
          customFormatTime(datePicked.toIso8601String(), AppStrings.formatDate);
    }
  }

  void _onSelectTimeEnd(BuildContext context) async {
    // ignore: use_build_context_synchronously
    final TimeOfDay? timePicker = await showTimePicker(
      context: context,
      initialTime: _selectedTimeEnd,
    );

    if (timePicker != null) {
      _selectedTimeEnd = timePicker;
      // ignore: use_build_context_synchronously
      _controllerTimeEnd.text = timePicker.format(context);
    }
  }

  void _onSelectDateEnd(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: _selectedDateEnd,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (datePicked != null) {
      _selectedDateEnd = datePicked;
      _controllerDateEnd.text =
          customFormatTime(datePicked.toIso8601String(), AppStrings.formatDate);
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
    const labelStyle = TextStyle(fontWeight: FontWeight.bold);
    const requiredStyle =
        TextStyle(fontWeight: FontWeight.bold, color: AppColors.dangerColor);

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Image:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerImage,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: AppColors.borderInput),
                    ),
                    hintText: 'Image',
                    filled: true,
                    fillColor: AppColors.backgroundInput,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter image';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Name:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerName,
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
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Time Start:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _controllerTime,
                        readOnly: true,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.borderInput),
                          ),
                          hintText: 'Time',
                          filled: true,
                          fillColor: AppColors.backgroundInput,
                          suffixIcon: Icon(Icons.schedule_outlined),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select time';
                          }
                          return null;
                        },
                        onTap: () => _onSelectTime(context),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: _controllerDate,
                          readOnly: true,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.borderInput),
                            ),
                            hintText: 'Date',
                            filled: true,
                            fillColor: AppColors.backgroundInput,
                            suffixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select date';
                            }
                            return null;
                          },
                          onTap: () => _onSelectDate(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Time End:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _controllerTimeEnd,
                        readOnly: true,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.borderInput),
                          ),
                          hintText: 'Time',
                          filled: true,
                          fillColor: AppColors.backgroundInput,
                          suffixIcon: Icon(Icons.schedule_outlined),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select time';
                          }
                          return null;
                        },
                        onTap: () => _onSelectTimeEnd(context),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: _controllerDateEnd,
                          readOnly: true,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.borderInput),
                            ),
                            hintText: 'Date',
                            filled: true,
                            fillColor: AppColors.backgroundInput,
                            suffixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select date';
                            }
                            return null;
                          },
                          onTap: () => _onSelectDateEnd(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Location:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerLocation,
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
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text('Price:', style: labelStyle),
                    SizedBox(width: 5),
                    Text('*', style: requiredStyle),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerPrice,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
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
                ),
                const SizedBox(height: 20),
                const Text('Address:', style: labelStyle),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerAddress,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: AppColors.borderInput),
                    ),
                    hintText: 'Address',
                    filled: true,
                    fillColor: AppColors.backgroundInput,
                  ),
                ),
              ],
            ),
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
