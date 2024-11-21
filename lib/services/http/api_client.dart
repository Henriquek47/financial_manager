import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:financial_manager/services/http/http_exeption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient extends ChangeNotifier {
  final Map<String, String> _mainHeaders = {"Content-Type": "application/json"};

  final String url = 'http://10.0.2.2:3333';

  final String activeChallenges = '/getActiveChallenges';

  Future<http.Response> getData(
    String path, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final Uri uri =
        Uri.parse('$url$path').replace(queryParameters: queryParams);
    final finalHeaders = {..._mainHeaders, if (headers != null) ...headers};
    try {
      final response = await http.get(uri, headers: finalHeaders).timeout(const Duration(seconds: 5));
      return _handleHttpResponse(response);
    } on HttpException catch (e) {
      throw HttpExceptionModel(e.message);
    } on TimeoutException {
      throw HttpExceptionModel("Conexão lenta");
    } on SocketException {
      throw HttpExceptionModel("Erro de conexão");
    } catch (e) {
      throw HttpExceptionModel("Algo deu errado");
    }
  }

  Future<http.Response> postData(
    String path, {
    Object? body,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final Uri uri =
        Uri.parse('$url$path').replace(queryParameters: queryParams);
    final finalHeaders = {..._mainHeaders, if (headers != null) ...headers};
    try {
      final response = await http.post(uri,
          headers: finalHeaders, body: body != null ? jsonEncode(body) : null).timeout(const Duration(seconds: 5));
      return _handleHttpResponse(response);
    } on HttpException catch (e) {
      throw HttpExceptionModel(e.message);
    } on TimeoutException {
      throw HttpExceptionModel("Conexão lenta");
    } on SocketException {
      throw HttpExceptionModel("Erro de conexão");
    } catch (e) {
      throw HttpExceptionModel("Algo deu errado");
    }
  }

  Future<http.Response> deleteData(
    String path, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final Uri uri =
        Uri.parse('$url$path').replace(queryParameters: queryParams);
    final finalHeaders = {..._mainHeaders, if (headers != null) ...headers};
    try {
      final response = await http.delete(uri, headers: finalHeaders);
      return _handleHttpResponse(response);
    } on HttpException catch (e) {
      throw HttpExceptionModel(e.message);
    } on TimeoutException {
      throw HttpExceptionModel("Conexão lenta");
    } on SocketException {
      throw HttpExceptionModel("Erro de conexão");
    } catch (e) {
      throw HttpExceptionModel("Algo deu errado");
    }
  }

  Future<http.Response> putData(
    String path, {
    Object? body,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final Uri uri =
        Uri.parse('$url$path').replace(queryParameters: queryParams);
    final finalHeaders = {..._mainHeaders, if (headers != null) ...headers};
    try {
      final response = await http.put(uri,
          headers: finalHeaders, body: body != null ? jsonEncode(body) : null);
      return _handleHttpResponse(response);
    } on HttpException catch (e) {
      throw HttpExceptionModel(e.message);
    } on TimeoutException {
      throw HttpExceptionModel("Conexão lenta");
    } on SocketException {
      throw HttpExceptionModel("Erro de conexão");
    } catch (e) {
      throw HttpExceptionModel("Algo deu errado");
    }
  }

  Future<http.Response> loadImageFromUrlWithHttp(String imageUrl) async {
    try {
      final response =
          await http.get(Uri.parse(imageUrl), headers: {'Accept': 'image/*'});
      return response;
    } on HttpException catch (e) {
      throw HttpExceptionModel(e.message);
    } on TimeoutException {
      throw HttpExceptionModel("Conexão lenta");
    } on SocketException {
      throw HttpExceptionModel("Erro de conexão");
    } catch (e) {
      throw HttpExceptionModel("Algo deu errado");
    }
  }

  http.Response _handleHttpResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      final body = jsonDecode(response.body);
      if (body['errors'] != null && (body['errors'] as List).isNotEmpty) {
        throw HttpException(
          body['errors'][0]['message'],
        );
      } else {
        throw const HttpException(
          'Algo deu errado',
        );
      }
    }
  }
}
