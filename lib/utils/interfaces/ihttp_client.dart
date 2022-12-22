import 'dart:async';

import 'dart:typed_data';

typedef HttpClientResponse = Future<Map<String, dynamic>>;

abstract class ApiException implements Exception {
  const ApiException();
}

class ConnectionException extends ApiException {
  const ConnectionException();
}

class ServerErrorException extends ApiException {
  final int? code;
  final String? message;

  const ServerErrorException({this.code, this.message});
}

class ClientErrorException extends ApiException {
  final int? code;
  final String? message;

  const ClientErrorException({this.code, this.message});
}

class UnknownApiException extends ApiException {
  const UnknownApiException();
}

abstract class IHttpClient {
  void setOnUserSessionExpired([void Function()? onUserSessionExpired]);

  FutureOr<void> setAuthenticationToken([String? token]);

  HttpClientResponse get(
    String url, {
    Map<String, dynamic> headers,
  });

  HttpClientResponse delete(
    String url, {
    Map<String, dynamic> headers,
  });

  HttpClientResponse post(
    String url, {
    Object body,
    Map<String, dynamic> headers,
  });

  HttpClientResponse patch(
    String url, {
    Object body,
    Map<String, dynamic> headers,
  });

  HttpClientResponse put(
    String url, {
    Object body,
    Map<String, dynamic> headers,
  });

  Future<Uint8List> download(
    String url, {
    Map<String, dynamic> headers = const {},
  });
}
