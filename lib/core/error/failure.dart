class Failure implements Exception{
  const Failure();
}

class FailureConncectInternet extends Failure  {
  final String error;
  const FailureConncectInternet({
    required this.error,
  });
}

class FailureConncectApi extends Failure  {
  final String error;
  const FailureConncectApi({
    required this.error,
  });
}

class FailureTokenExpired extends Failure  {
  final String error;
  const FailureTokenExpired({
    required this.error,
  });
}

class FailureUnknown extends Failure  {
  final String error;
  const FailureUnknown({
    required this.error,
  });
}
