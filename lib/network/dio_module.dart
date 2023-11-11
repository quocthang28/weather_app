import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  AppDio();

  Dio? _dio;

  Dio get dio {
    if (_dio != null) {
      return _dio!;
    }
    BaseOptions options = BaseOptions(
      baseUrl: 'http://10.0.2.2:3939',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 15),
    );
    _dio = Dio(options);

    _dio!.interceptors.add(PrettyDioLogger(request: true, requestBody: false, responseBody: false, requestHeader: false));
    //_dio!.interceptors.add(ResponseInterceptor());
    _dio!.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 5),
        Duration(seconds: 10),
        Duration(seconds: 15),
      ],
      //retryableExtraStatuses: {status401Unauthorized},
    ));

    return _dio!;
  }
}