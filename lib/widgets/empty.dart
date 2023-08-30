import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/utils/screen_size.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key,
      this.title = 'No data',
      this.description = 'Make sure you have data'});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/images/empty_data_icon.png'),
            width: screenSize.width * 0.6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(description),
        ],
      ),
    );
  }
}
