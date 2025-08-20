import 'package:debate_app/features/Topics/presentation/widgets/skeleton_row.dart';
import 'package:flutter/material.dart';

class LoadingSliverListSkeleton extends StatelessWidget {
  final int topicCount;
  const LoadingSliverListSkeleton({super.key, required this.topicCount});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      sliver: SliverList.separated(
        itemCount: topicCount,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => const SkeletonRow(),
      ),
    );
  }
}
