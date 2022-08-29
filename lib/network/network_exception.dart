import 'dart:convert';

/// 网络错误
class NetworkException implements Exception {
  late String errorMessage;

  NetworkException(String body) {
    final jsonMaps = jsonDecode(body);

    final value = jsonMaps["error"];
    if (value == null) {
      // 如果返回信息中没有error字段
      errorMessage = "未知错误: " + body;
    } else {
      errorMessage = "API Exception: " + value;
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}
