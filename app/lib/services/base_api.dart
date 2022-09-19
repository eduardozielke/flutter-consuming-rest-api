import 'dart:convert';

import 'package:app/models/api_response.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
const headers = {
  'apiKey': 'ed30b444-87b9-4f30-8a47-abcf9fd066e8',
  'Content-Type': 'application/json'
};

class BaseApi {
  Future<APIResponse> get(String api) async {
    Uri url = Uri.parse(baseUrl + api);
    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return APIResponse(
        data: response.body,
      );
    }
    return APIResponse(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse> post(String api, payload) async {
    Uri url = Uri.parse(baseUrl + api);
    var jsonPayload = json.encode(payload);
    var response = await http.post(
      url,
      headers: headers,
      body: jsonPayload,
    );

    if (response.statusCode < 300) {
      return APIResponse(
        data: response.body,
      );
    }

    return APIResponse(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<APIResponse> put(String api, payload) async {
    Uri url = Uri.parse(baseUrl + api);
    var jsonPayload = json.encode(payload);
    var response = await http.put(
      url,
      headers: headers,
      body: jsonPayload,
    );

    if (response.statusCode < 300) {
      return APIResponse(
        error: false,
        errorMessage: 'Successfully updated',
      );
    }
    return APIResponse(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }

  Future<dynamic> delete(String api) async {
    Uri url = Uri.parse(baseUrl + api);
    var response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode < 300) {
      return APIResponse(data: response.body);
    }

    return APIResponse(
      error: true,
      errorMessage: 'An error ocurred',
    );
  }
}
