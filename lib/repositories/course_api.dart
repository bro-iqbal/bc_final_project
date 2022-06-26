import 'dart:io';

import 'package:bc_final_project/constants/api.dart';
import 'package:bc_final_project/helpers/user_email.dart';
import 'package:bc_final_project/models/responses.dart';
import 'package:dio/dio.dart';

class CourseApi {
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

  Future<APIResponse> getCourse() async {
    final result = await _getRequest(
      endpoint: ApiRoute.exerciseMapel,
      param: {
        "major_name": "IPA",
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<APIResponse> getPaketSoal(id) async {
    final result = await _getRequest(
      endpoint: ApiRoute.exercisePaketSoal,
      param: {
        "course_id": id,
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<APIResponse> getBanner() async {
    final result = await _getRequest(
      endpoint: ApiRoute.banner,
      // param: {
      //   "limit": "IPA",
      // },
    );
    return result;
  }

  Future<APIResponse> getResult(id) async {
    final result = await _getRequest(
      endpoint: ApiRoute.exerciseSkor,
      param: {
        "exercise_id": id,
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<APIResponse> postQuestionList(id) async {
    final result = await _postRequest(
      endpoint: ApiRoute.exerciseKerjakanSoal,
      body: {
        "exercise_id": id,
        "user_email": UserEmail.getUserEmail(),
      },
    );
    return result;
  }

  Future<APIResponse> postStudentAnswer(payload) async {
    final result = await _postRequest(
        endpoint: ApiRoute.exerciseSubmitJawaban, body: payload);
    return result;
  }
}
