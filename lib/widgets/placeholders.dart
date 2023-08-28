import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class ListItemPlaceholder extends StatelessWidget {
  const ListItemPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 60,
          height: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}

class CardPlaceholder extends StatelessWidget {
  const CardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: AppColors.backgroundCard,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.cardBorderRadius,
      ),
      elevation: 2.0,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
