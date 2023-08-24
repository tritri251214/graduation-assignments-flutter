import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'placeholders.dart';

class LoadingListEvent extends StatefulWidget {
  const LoadingListEvent({super.key});

  @override
  State<LoadingListEvent> createState() => _LoadingListEventState();
}

class _LoadingListEventState extends State<LoadingListEvent> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
            SizedBox(height: 20),
            ListItemPlaceholder(),
          ],
        ),
      ));
  }
}

class LoadingDetailPage extends StatefulWidget {
  const LoadingDetailPage({super.key});

  @override
  State<LoadingDetailPage> createState() => _LoadingDetailPageState();
}

class _LoadingDetailPageState extends State<LoadingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
            SizedBox(height: 20),
            DetailPlaceholder(),
          ],
        ),
      ));
  }
}

class LoadingLatestEvent extends StatefulWidget {
  const LoadingLatestEvent({super.key});

  @override
  State<LoadingLatestEvent> createState() => _LoadingLatestEventState();
}

class _LoadingLatestEventState extends State<LoadingLatestEvent> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            CardPlaceholder(),
          ],
        ),
      ));
  }
}
