import 'package:debate_app/core/config/api_config.dart';
import 'package:dio/dio.dart';

abstract class ChatDatasource {
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    int? sessionId,
  });
}

class ChatDatasourceImpl implements ChatDatasource {
  final Dio dio;

  ChatDatasourceImpl({required this.dio});
  @override
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    int? sessionId,
  }) async {
    try {
      final apiUrl = ApiConfig.chatEndpoint;
      final Map<String, dynamic> data = {"prompt": prompt};

      if (sessionId != null) {
        data['sessionId'] = sessionId;
      }

      final response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else {
          throw Exception("Format Tidak sesuai");
        }
      } else {
        throw Exception("Gagal mengirim pesan: ${response.statusMessage}");
      }
    } catch (e) {
      print("Error dalam pengiriman pesan: $e");
      rethrow;
    }
  }
}
