class ApiConfig {
  // Untuk bagian debugURL ini saya dapatkan dari ifconfig fi terminal macos.
  static const String _debugBaseUrl = "http://192.168.---.---:8000";
  static const String _releaseBaseUrl = "https://your-production-server.com";

  static String get baseUrl {
    const bool isDebugMode = bool.fromEnvironment('dart.vm.product') == false;
    return isDebugMode ? _debugBaseUrl : _releaseBaseUrl;
  }

  static String get chatEndpoint => "$baseUrl/api/chat/";
  static String get topicsEndpoint => "$baseUrl/api/topics/";
}
