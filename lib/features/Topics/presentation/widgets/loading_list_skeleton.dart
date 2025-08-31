import 'package:debate_app/features/Topics/presentation/widgets/skeleton_row.dart';
import 'package:flutter/material.dart';

class LoadingListSkeleton extends StatelessWidget {
  const LoadingListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => const SkeletonRow(),
    );
  }
}
