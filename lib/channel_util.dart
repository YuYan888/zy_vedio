import 'package:flutter/services.dart';

class ChannelUtil {
  static MethodChannel _methodChannel = MethodChannel('CommonChannel');
  // 简单传值——flutter调用原生
  // MethodChannel是Flutter和原生交互的基础，
  // 通过传入Flutter插件的名字，调用invokeMethod方法，
  // 便可以调用原生的方法，有点类似于Java的反射。


  static closeCamera() {
    _methodChannel.invokeMethod('closeCamera');
  }
}