import 'package:debate_app/core/config/api_config.dart';
import 'package:debate_app/shared/utils/logger.dart';
import 'package:dio/dio.dart';

abstract class ChatDatasource {
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    int? sessionId,
  });

  Future<Map<String, dynamic>> createSession({
    required String prompt,
    required String topic,
    required String role,
  });
}

class ChatDatasourceImpl implements ChatDatasource {
  final Dio dio;
  ChatDatasourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> createSession({
    required String prompt,
    required String topic,
    required String role,
  }) async {
    try {
      final body = {"prompt": prompt, "topic": topic, "pihak": role};

      final response = await dio.post(ApiConfig.chatEndpoint, data: body);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(response.data);
      }
      throw Exception(
        "Format respons tidak sesuai / statusCode: ${response.statusCode}",
      );
    } catch (e, st) {
      AppLogger.error("createSession error", e);
      AppLogger.error("stack", st);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    int? sessionId,
  }) async {
    try {
      final body = {
        "prompt": prompt,
        if (sessionId != null) "sessionId": sessionId,
      };

      final response = await dio.post(ApiConfig.chatEndpoint, data: body);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(response.data);
      }
      throw Exception(
        "Format respons tidak sesuai / statusCode: ${response.statusCode}",
      );
    } catch (e, st) {
      AppLogger.error("sendMessage error", e);
      AppLogger.error("stack", st);
      rethrow;
    }
  }
}
