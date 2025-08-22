import 'package:debate_app/features/Debate/data/datasources/chat_datasource.dart';
import 'package:debate_app/features/Debate/data/repositories/chat_repository_impl.dart';
import 'package:debate_app/features/Debate/domain/repositories/chat_repository.dart';
import 'package:debate_app/features/Debate/domain/usecases/create_session_usecase.dart';
import 'package:debate_app/features/Debate/domain/usecases/send_message_usecase.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Topics/data/datasources/topic_datasource.dart';
import 'package:debate_app/features/Topics/data/repositories/topic_repository_impl.dart';
import 'package:debate_app/features/Topics/domain/repositories/topic_repository.dart';
import 'package:debate_app/features/Topics/domain/usecases/get_topic_usecase.dart';
import 'package:debate_app/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Debate
  sl.registerFactory(() => DebateBloc(sendMessage: sl(), createSession: sl()));
  sl.registerLazySingleton(() => SendmessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateSessionUsecase(repository: sl()));
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<ChatDatasource>(() => ChatDatasourceImpl(dio: sl()));

  // Topics
  sl.registerFactory(() => TopicsBloc(getTopicUsecase: sl()));
  sl.registerLazySingleton(() => GetTopicUsecase(repository: sl()));
  sl.registerLazySingleton<TopicRepository>(
    () => TopicRepositoryImpl(topicDatasource: sl()),
  );
  sl.registerLazySingleton<TopicDatasource>(
    () => TopicDatasourceImpl(dio: sl()),
  );

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        error: true,
      ),
    );
    return dio;
  });
}
