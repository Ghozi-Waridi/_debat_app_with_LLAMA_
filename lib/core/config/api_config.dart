class ApiConfig {
  static const String _debugBaseUrl = "http://192.168.18.76:8000"; // URL untuk api lokal sebagai pengembangan
  static const String _releaseBaseUrl = ""; // URL untuk api public nantinya

  static String get baseUrl {
    const bool isDebugMode = bool.fromEnvironment('dart.vm.product') == false;
    return isDebugMode ? _debugBaseUrl : _releaseBaseUrl;
  }

  static String get chatEndpoint => "$baseUrl/api/chat/";
  static String get topicsEndpoint => "$baseUrl/api/topics/";
}
