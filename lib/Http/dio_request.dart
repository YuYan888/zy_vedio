import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/// 请求方法
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

class DioUtil {
  /// 单例模式
  static DioUtil? _instance;
  factory DioUtil() => _instance ?? DioUtil._internal();
  static DioUtil? get instance => _instance ?? DioUtil._internal();
  // https://sy.smartlink.com.cn:44300/test/faw/drv/api/user/app/login?
  // https://sy.smartlink.com.cn:44300/dev/faw/drv/api/user/app/login?&loginName=15600000001&password=Aa%4013579&product=qingqi&captcha=

  /// 连接超时时间
  static const int connectTimeout = 60 * 1000;

  /// 响应超时时间
  static const int receiveTimeout = 60 * 1000;

  /// Dio实例
  static Dio _dio = Dio();

  /// 初始化
  DioUtil._internal() {
    // 初始化基本选项
    // dart 参数类型“int”不能直接分配给参数类型“Duration”，需要Duration(seconds: connectTimeout) milliseconds毫秒

    BaseOptions options = BaseOptions(
        baseUrl: 'https://sy.smartlink.com.cn:44300/test/faw/drv/api/',
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout));
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 对非open的接口的请求参数全部增加userId
    if (!options.path.contains("open")) {
      // options.queryParameters["userId"] = "xxx";
    }
    // 头部添加token
    // options.headers["token"] = "xxx";
    options.headers["deviceId"] = "2A1191F1-AA0A-4048-BE94-4A01F0CB6531";
    options.headers["deviceType"] = "ios";
    options.headers["appVersion"] = "1";
    options.headers["product"] = "faw";
    options.headers["deviceModel"] = "faw";
    options.headers["systemVersion"] = "14.7.1";


    // 更多业务需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  /// 相应拦截器
  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      // ....
    } else {
      print("This is Center Short Toast");
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // ....
    }
    if (response.requestOptions.baseUrl.contains("???????")) {
      // 对某些单独的url返回数据做特殊处理
    }
    handler.next(response);
  }

  /// 错误处理
  void _onError(DioError error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }

  /// 请求类
  Future<T> request<T>(
      String path, {
        DioMethod method = DioMethod.get,
        Map<String, dynamic>? params,
        data,
        CancelToken? cancelToken,
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    options ??= Options(method: _methodValues[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前 DioUtil.instance?.openLog();
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}
