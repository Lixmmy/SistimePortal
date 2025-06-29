
class FailureConncectInternet implements Exception  {
  final String error;
  const FailureConncectInternet({
    required this.error,
  });
}

class FailureConncectApi implements Exception  {
  final String error;
  const FailureConncectApi({
    required this.error,
  });
}

class FailureTokenExpired implements Exception  {
  final String error;
  const FailureTokenExpired({
    required this.error,
  });
}

class FailureUnknown implements Exception  {
  final String error;
  const FailureUnknown({
    required this.error,
  });
}