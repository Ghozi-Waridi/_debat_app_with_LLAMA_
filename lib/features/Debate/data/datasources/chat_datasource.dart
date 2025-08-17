import 'package:debate_app/core/config/api_config.dart';
import 'package:dio/dio.dart';

abstract class ChatDatasource {
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    int? sessionId,
    String? topic,
    String? pihak,
  });
}

class ChatDatasourceImpl implements ChatDatasource {
  final Dio dio;

  ChatDatasourceImpl({required this.dio});
  @override
  Future<Map<String, dynamic>> sendMessage({
    required String prompt,
    String? topic,
    String? pihak,
    int? sessionId,
  }) async {
    try {
      // print("SessionID DataSource : ${sessionId}");
      final apiUrl = ApiConfig.chatEndpoint;
      final Map<String, dynamic> data = {"prompt": prompt};

      if (topic != null) {
        data['topic'] = topic;
      }
      if (pihak != null) {
        data['pihak'] = pihak;
      }

      if (sessionId != null) {
        data['sessionId'] = sessionId;
      }
      // print("Data yang dikirim: $data");
      final response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
        ),
      );
      // print("Response: ${response.data["session_id"]}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          // print("test");
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
