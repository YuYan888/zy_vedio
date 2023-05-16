
import 'package:flutter/material.dart';

import '../../Http/dio_request.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../toast.dart';

class LoginService {
  /// 单例模式
  static LoginService? _instance;
  factory LoginService() => _instance ?? LoginService._internal();
  static LoginService? get instance => _instance ?? LoginService._internal();

  /// 初始化
  LoginService._internal() {
    // 初始化基本选项
  }

  /// 获取权限列表
  getUser() async {
    /// 开启日志打印
    DioUtil.instance?.openLog();

    /// 发起网络接口请求 get_user
    var result = await DioUtil().request('/get_user', method: DioMethod.get);
    return result.data;
  }

  login() async {
    /// 开启日志打印
    DioUtil.instance?.openLog();
    var data = {
      "loginName": "15600000001",
      "password": "Aa@13579",
      "product": "qingqi",
      "captcha": "",
    };
    /// 发起网络接口请求 get_user
    var result = await DioUtil().request('/user/app/login?', method: DioMethod.post,params:data);
    
    print("result----${result}");

    if  (result["code"] != 200) {

      Toast.showHud( result["message"],type: ToastType.black);

    return result.data;
  }
}
