import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';

class NewBadgeWidget extends StatelessWidget {
  const NewBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.newBadgeBorderRadius,
        color: AppColors.primaryColor,
      ),
      child: const Center(
        child: Text('New', style: TextStyle(fontFamily: AppStrings.rootFont, color: AppColors.white)),
      ),
    );
  }
}
