import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/widgets/loading.dart';

class LoadImage extends StatelessWidget {
  const LoadImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
      errorWidget: (_, __, ___) => const Icon(Icons.image_outlined, color: AppColors.dangerColor, size: 40),
    );
  }
}
