import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';
import 'package:debate_app/features/Topics/domain/usecases/get_topic_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final GetTopicUsecase getTopicUsecase;
  TopicsBloc({required this.getTopicUsecase}) : super(TopicsInitial()) {
    on<GetTopicsEvent>((event, emit) async {
      emit(TopicsLoadingState());
      try {
        final topics = await getTopicUsecase();
        emit(GetTopicsState(topics: topics));
      } catch (e) {
        emit(TopicsErrorState(message: e.toString()));
      }
    });
  }
}
