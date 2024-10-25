import 'dart:convert';
import 'package:ecommerce/data/models/api_response.dart';
import 'package:ecommerce/presentation/state_holders/state_holders.dart';
import 'package:ecommerce/presentation/ui/screens/email_verification_screen.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {
  late final Logger logger;
  final AuthController authController;

  ApiCaller({required this.logger, required this.authController});

  Future<ApiResponse> getRequest({required String url, String? token}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, '', {}, {});

      final Response response = await get(
        uri,
        headers: {
          'token': '${token ?? AuthController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        _responseLog(
          url,
          true,
          response.statusCode,
          response.headers,
          response.body,
        );
        final decodedResponseBody = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedResponseBody,
        );
      } else {
        _responseLog(
          url,
          false,
          response.statusCode,
          response.headers,
          response.body,
        );
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        return ApiResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      _responseLog(url, false, -1, {}, {}, error);
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: error.toString(),
      );
    }
  }

  Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, '', body ?? {}, {});

      final Response response = await post(
        uri,
        headers: {
          'token': '${token ?? AuthController.accessToken}',
          'content-type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        _responseLog(
          url,
          true,
          response.statusCode,
          response.headers,
          response.body,
        );
        final decodedResponseBody = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseBody: decodedResponseBody,
        );
      } else {
        _responseLog(
          url,
          false,
          response.statusCode,
          response.headers,
          response.body,
        );
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        return ApiResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      _responseLog(url, false, -1, {}, {}, error);
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> _moveToLogin() async {
    await authController.clearUserData();
    getx.Get.to(() => const EmailVerificationScreen());
  }

  void _requestLog(
    String url,
    String token,
    Map<String, dynamic> body,
    Map<String, dynamic> params,
  ) {
    logger.i('''
    Url: $url
    Token: $token
    Body: $body
    Params: $params
    ''');
  }

  void _responseLog(
    String url,
    bool isSuccess,
    int statusCode,
    Map<String, dynamic> header,
    dynamic responseBody, [
    dynamic error,
  ]) {
    String message = '''
    Url: $url
    Status Code: $statusCode
    Headers: $header,
    body: $responseBody,
    Error: $error
    ''';

    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}
