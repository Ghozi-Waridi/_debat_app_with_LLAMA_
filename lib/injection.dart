import 'package:debate_app/features/Debate/data/datasources/chat_datasource.dart';
import 'package:debate_app/features/Debate/data/repositories/chat_repository_impl.dart';
import 'package:debate_app/features/Debate/domain/repositories/chat_repository.dart';
import 'package:debate_app/features/Debate/domain/usecases/sendMessage_usecase.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


Future<void> init() async {
   sl.registerFactory(() => DebateBloc(sendMessage: sl()));
   sl.registerLazySingleton(() => SendmessageUsecase(repository: sl()));
   sl.registerLazySingleton<CahtRepository>(
      () => ChatRepositoryImpl(datasource: sl())
   );
   sl.registerLazySingleton<ChatDatasource>(
      () => ChatDatasourceImpl(dio: sl())
   );

   sl.registerLazySingleton(() {
         final dio = Dio();
         dio.options.connectTimeout = const Duration(seconds: 30);
         dio.options.receiveTimeout = const Duration(seconds: 30);
         dio.options.sendTimeout = const Duration(seconds: 30);
         dio.interceptors.add (
         LogInterceptor(
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            requestHeader: true,
            error: true
         ) 
         );
         return dio;
      });
}
