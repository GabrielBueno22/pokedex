import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex/utils/interfaces/ihttp_client.dart';

extension _RequestParse on RequestOptions {
  /// FormData is unsupported
  String? toCurl() {
    final List<String> components = ['curl -i'];

    if (data is FormData) return null;

    if (method.toUpperCase() != 'GET') {
      components.add('-X $method');
    }

    headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (data != null) {
      final parsed = json.encode(data!).replaceAll('"', '\\"');
      components.add('-d "$parsed"');
    }

    components.add('"${uri.toString()}"');

    return components.join(' \\\n\t');
  }
}

extension _ReponseParse on Response<String> {
  HttpClientResponse parse() async {
    Map<String, dynamic> result;
    try {
      if (data != null) {
        result = Map.castFrom((await compute(jsonDecode, data!)) as Map);
      } else {
        throw Exception('data=$data');
      }
    } catch (e) {
      result = {
        'message': data,
        'exception': e.toString(),
      };
    }
    return result;
  }
}

class DioHttpClient implements IHttpClient {
  final Dio client;
  final bool debug;

  DioHttpClient({required this.client, this.debug = false}) {
    client.interceptors.add(dioLoggerInterceptor);
  }

  @override
  FutureOr<void> setAuthenticationToken([String? token]) {}

  Future<Response<T>> request<T>(RequestOptions options) async {
    void _toCurl(Response<dynamic> response) {
      try {
        final status = '${response.statusCode} ${response.statusMessage}';
        final curl = response.requestOptions.toCurl() ??
            'Curl of ${response.requestOptions.path} is unavailable';

        log('$status\n$curl', name: '$DioHttpClient');
      } catch (_) {}
    }

    try {
      final response = await client.fetch<T>(options);
      if (debug) _toCurl(response);
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          final response = e.response!;
          if (debug) _toCurl(response);

          final Map<String, dynamic> json = {
            'message':
                response.data != null ? '${response.data}' : e.toString(),
          };
          final statusCode = response.statusCode;

          if (statusCode != null) {
            if (statusCode >= 400 && statusCode < 500) {
              if (statusCode == 401) {
                throw const ConnectionException();
              }
              throw ClientErrorException(
                code: statusCode,
                message: '${json['message']}',
              );
            }

            if (statusCode >= 500 && statusCode < 600) {
              throw ServerErrorException(
                code: statusCode,
                message: '${json['message']}',
              );
            }
          }
        } else {
          throw const ConnectionException();
        }
      }
      throw const UnknownApiException();
    }
  }

  @override
  HttpClientResponse delete(String url,
      {Map<String, dynamic> headers = const {}}) async {
    final response = await request<String>(
      RequestOptions(
        path: url,
        method: 'DELETE',
        headers: headers,
      ),
    );

    return response.parse();
  }

  @override
  HttpClientResponse get(String url,
      {Map<String, dynamic> headers = const {}}) async {
    final response = await request<String>(
      RequestOptions(
        path: url,
        method: 'GET',
        headers: headers,
      ),
    );

    return response.parse();
  }

  @override
  HttpClientResponse patch(
    String url, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    final response = await request<String>(
      RequestOptions(
        path: url,
        method: 'PATCH',
        headers: headers,
        data: jsonEncode(body),
      ),
    );

    return response.parse();
  }

  @override
  HttpClientResponse post(
    String url, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    final response = await request<String>(
      RequestOptions(
        path: url,
        method: 'POST',
        headers: headers,
        data: body is FormData ? body : jsonEncode(body),
      ),
    );

    return response.parse();
  }

  @override
  HttpClientResponse put(
    String url, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    final response = await request<String>(
      RequestOptions(
        path: url,
        method: 'PUT',
        headers: headers,
        data: jsonEncode(body),
      ),
    );

    return response.parse();
  }

  @override
  Future<Uint8List> download(
    String url, {
    Map<String, dynamic> headers = const {},
  }) async {
    final response = await request<Uint8List>(
      RequestOptions(
        path: url,
        method: 'GET',
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );

    return response.data ?? Uint8List(0);
  }

  @override
  void setOnUserSessionExpired([void Function()? onUserSessionExpired]) {}
}
