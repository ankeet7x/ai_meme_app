import 'package:http/http.dart' as http;
import 'package:meminder/app/functions/dialog_helper.dart';
import 'package:meminder/app/functions/service_locator.dart';
import 'package:meminder/app/functions/shared_preferences_services.dart';
import 'package:meminder/core/network/get_header.dart';

class NetworkBaseClient {
  Future<http.Response?> getRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    required String path,
    bool shouldCache = false,
  }) async {
    http.Response? response;
    try {
      Map<String, String> header = getHeader();
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      response = await http.get(
        Uri.parse(
          baseUrl + path,
        ),
        headers: header,
      );
      if (response.statusCode == 200 && shouldCache) {
        setString(
          path,
          response.body,
        );
      }
    } catch (e) {
      if (shouldCache) {
        String? responseBody = getString(path);
        if (responseBody != null) {
          response = http.Response(responseBody, 200);
        }
      }
    }
    return response;
  }

  Future<http.Response?> postRequest({
    String baseUrl = "",
    Map<String, String>? optionalHeaders,
    required String path,
    Map<String, dynamic>? body,
    bool showDialog = true,
  }) async {
    if (showDialog) {
      showLoadingDialog();
    }
    http.Response? response;
    try {
      Map<String, String> header = getHeader();
      if (optionalHeaders != null) {
        header.addAll(optionalHeaders);
      }
      response = await http.post(
        Uri.parse(
          baseUrl + path,
        ),
        headers: header,
        body: body,
      );
    } catch (e) {}
    if (showDialog) {
      hideDialog();
    }
    return response;
  }
}
