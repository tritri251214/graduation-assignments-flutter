import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';

class LoadImage extends StatelessWidget {
  const LoadImage({super.key, required this.imageUrl, this.borderRadius});

  final String imageUrl;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/empty_data_icon.png'), context);

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (_, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (_, __) =>
          const LoadingImage(width: double.infinity, height: double.infinity),
      errorWidget: (_, __, ___) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? AppDimensions.borderButtonRadius,
          border: Border.all(color: AppColors.dangerColor),
          color: AppColors.dangerColor,
        ),
        child: const Image(image: AssetImage('assets/images/empty_data_icon.png')),
      ),
    );
  }
}
