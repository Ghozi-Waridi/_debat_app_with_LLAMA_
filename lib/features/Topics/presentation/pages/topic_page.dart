import 'dart:async';
import 'package:debate_app/core/theme/color.dart';
import 'package:debate_app/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:debate_app/features/Topics/presentation/widgets/empty_state.dart';
import 'package:debate_app/features/Topics/presentation/widgets/error_state.dart';
import 'package:debate_app/features/Topics/presentation/widgets/loading_silver_list_skeleton.dart';
import 'package:debate_app/features/Topics/presentation/widgets/search_field.dart';
import 'package:debate_app/features/Topics/presentation/widgets/topic_tile.dart';
import 'package:debate_app/shared/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final TextEditingController _search = TextEditingController();
  final Debouncer _debounce = Debouncer();
  int? _lastTopicCount;
  Timer? _poller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh(context);
      _poller = Timer.periodic(const Duration(seconds: 30), (_) async {
        if (!mounted) return;
        final bloc = context.read<TopicsBloc>();
        if (bloc.state is TopicsLoadingState) return;
        bloc.add(GetTopicsEvent());
      });
    });
  }

  @override
  void dispose() {
    _poller?.cancel();
    _debounce.dispose();
    _search.dispose();
    super.dispose();
  }

  void _onSearchChanged(String _) {
    _debounce(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<TopicsBloc>();
    if (bloc.state is TopicsLoadingState) {
      await bloc.stream.firstWhere(
        (s) => s is GetTopicsState || s is TopicsErrorState,
      );
      return;
    }

    bloc.add(GetTopicsEvent());
    await bloc.stream.firstWhere(
      (s) => s is GetTopicsState || s is TopicsErrorState,
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select<TopicsBloc, String?>((bloc) {
      final s = bloc.state;
      return s is TopicsErrorState ? s.message : null;
    });

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: ErrorState(
            message: errorMessage,
            onRetry: () => _onRefresh(context),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: BlocListener<TopicsBloc, TopicsState>(
            listener: (context, state) {
              if (state is GetTopicsState) {
                _lastTopicCount = state.topics.length;
              }
            },
            child: RefreshIndicator.adaptive(
              onRefresh: () => _onRefresh(context),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SearchField(
                        controller: _search,
                        hint: 'Cari topik…',
                        onChanged: _onSearchChanged,
                        onClear: () {
                          _search.clear();
                          _onSearchChanged('');
                        },
                      ),
                    ),
                  ),
                  BlocSelector<TopicsBloc, TopicsState, List<dynamic>?>(
                    selector:
                        (state) =>
                            state is GetTopicsState ? state.topics : null,
                    builder: (context, topics) {
                      final isLoading = context.select<TopicsBloc, bool>(
                        (bloc) => bloc.state is TopicsLoadingState,
                      );

                      if (isLoading && topics == null) {
                        // gunakan jumlah terakhir jika ada; fallback ke 6
                        return LoadingSliverListSkeleton(
                          topicCount: _lastTopicCount ?? 6,
                        );
                      }

                      final q = _search.text.trim().toLowerCase();
                      final filtered =
                          (topics ?? const <dynamic>[])
                              .where(
                                (t) => (t.topic as String)
                                    .toLowerCase()
                                    .contains(q),
                              )
                              .toList();

                      if (filtered.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyState(
                            title: 'Topik tidak ditemukan',
                            subtitle:
                                'Coba kata kunci lain atau tarik untuk refresh.',
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        sliver: SliverList.separated(
                          itemCount: filtered.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final topic = filtered[index];
                            return TopicTile(topic: topic);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
