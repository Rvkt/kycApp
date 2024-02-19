import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'network_response.dart';

class NetworkCall {
  static post({
    required String url,
    required Map<String, String> headers,
    String? body,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        networkResponse = NetworkResponse(
          status: true,
          data: response.body,
        );
      } else {
        networkResponse = NetworkResponse(
          status: false,
          data: response.body,
        );
      }
    } catch (e) {
      log(e.toString(), name: 'Network Post Call');
      // logger.shout(e.toString());
      networkResponse = NetworkResponse(
        status: false,
        errorMessage: e.toString(),
      );
    }
    return networkResponse;
  }

  static get({
    required String url,
    required Future<Map<String, String>> headers,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: await headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        networkResponse = NetworkResponse(
          status: true,
          data: response.body,
        );
      } else {
        networkResponse = NetworkResponse(
          status: false,
          data: response.body,
        );
      }
    } catch (e) {
      Logger().e(e);
      // log(e.toString(), name: 'Network Get Call');
      // log('Network Get: ${e.toString()}');
      // logger.shout(e.toString());
      networkResponse = NetworkResponse(
        status: false,
        errorMessage: e.toString(),
      );
    }
    return networkResponse;
  }
}
