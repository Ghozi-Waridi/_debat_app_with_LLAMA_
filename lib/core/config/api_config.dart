class ApiConfig {
  static const String _debugBaseUrl = "https://6a08729775b1.ngrok-free.app";
  static const String _releaseBaseUrl = "https://your-production-server.com";

  static String get baseUrl {
    const bool isDebugMode = bool.fromEnvironment('dart.vm.product') == false;
    return isDebugMode ? _debugBaseUrl : _releaseBaseUrl;
  }

  static String get chatEndpoint => "$baseUrl/api/chat/";
  static String get topicsEndpoint => "$baseUrl/api/topics/";
}
