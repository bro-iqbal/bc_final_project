import 'dart:io';

import 'package:dio/dio.dart';
import 'package:bc_final_project/constants/api.dart';
import 'package:bc_final_project/helpers/user_email.dart';
import 'package:bc_final_project/models/responses.dart';

class ApiHandler {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiRoute.baseUrl,
      headers: {
        "x-api-key": ApiRoute.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    return dio;
  }

  Future<APIResponse> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return APIResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return APIResponse.error(null, "request timeout");
      }
      return APIResponse.error(null, "request error dio");
    } catch (e) {
      return APIResponse.error(null, "other error");
    }
  }

  Future<APIResponse> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return APIResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return APIResponse.error(null, "request timeout");
      }
      return APIResponse.error(null, "request error dio");
    } catch (e) {
      return APIResponse.error(null, "other error");
    }
  }

  Future<APIResponse> getUserByEmail() async {
    final result = await _getRequest(
      endpoint: ApiRoute.users,
      param: {
        "email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<APIResponse> postRegister(body) async {
    final result = await _postRequest(
      endpoint: ApiRoute.userRegistrasi,
      body: body,
    );
    return result;
  }
}
