enum MessageExcType { networkError, apiError, tokenExpired, unknown }

class MessageExc implements Exception {
  final MessageExcType type;
  final int? statusCode;
  final String message;
  final dynamic responseBody;
  final dynamic data;

  const MessageExc(
    this.type,
    this.message, {
    this.statusCode,
    this.responseBody,
    this.data,
  });

  factory MessageExc.network(String message) {
    return MessageExc(MessageExcType.networkError, message);
  }

  factory MessageExc.api(String message) {
    return MessageExc(MessageExcType.apiError, message);
  }

  factory MessageExc.tokenExpired({String? message = ''}) {
    return MessageExc(MessageExcType.tokenExpired, message ?? '', statusCode: 401);
  }

  factory MessageExc.unknown(String message) {
    return MessageExc(MessageExcType.unknown, message);
  }

  @override
  String toString() {
    return message;
  }
}
