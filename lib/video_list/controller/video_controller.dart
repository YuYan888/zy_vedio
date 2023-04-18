import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/video_model.dart';
/**
 * 1、抽象类不能被实例化，只有继承它的子类可以。
 * 2、抽象类中一般我们把没有方法体的方法称为抽象方法。
 * 3、子类继承抽象类必须实现它的抽象方法。
 * 4、如果把抽象类当做接口实现的话必须得实现抽象类里面定义的所有属性和方法。
 */

abstract class VideoController {
   List<VideoModel>? dataList;

   /// 针对不同的类型视频，采用不同的key存储
   String get spKey;
   /// 返回不同类型的视频内容
   String get videoData;
   /// 随机数
   int get count => Random().nextInt(1000);

   Future<void> init() async {
     // 首先判断一级缓存——即内存中是否有数据
     print('MOOC- init video controller');

     if(dataList == null){
       print('MOOC- model is null');
       // 如果没有，则从二级/三级缓存查找
       dataList = await fetchVideoData();
     }
   }

   // 缺点：
   // 1、需要针对json的每个字段创建get方法，一旦字段多了会非常繁琐
   // 2、需要保证map的字段和json的字段完全一致， 容易出错

   Future<List<VideoModel>> fetchVideoData() async {

     var sp = await SharedPreferences.getInstance();
     var modelStr = sp.getString(spKey);
     print('MOOC- fetchVideoData');

     if(modelStr != null && modelStr.isNotEmpty) {
       //二级缓存中找到数据， 直接使用
       print('MOOC- 2/use sp data');

       var list = jsonDecode(modelStr) as List<dynamic>;
       // jsonDecode获取到的是“List<Map>”，需要转换成List<VideoModel>
       // List<Map> => List<VideoModel>

       return list.map((e) => VideoModel.fromJson(e)).toList();

     }else {
       // 二级缓存未找到数据，走三级缓存
       // var list = jsonEncode(videoData) as List<dynamic>;//对 JSON 格式的字符串进行编码
       var list = jsonDecode(videoData) as List<dynamic>;//对 JSON 格式的字符串进行解码

       var sp = await SharedPreferences.getInstance();

       sp.setString(spKey, videoData);
       print('MOOC- 3/fetch data from server');
       return list.map((e) => VideoModel.fromJson(e)).toList();
     }
   }
 }

   //  Flutter 中 function 和 method 区别
   // Flutter 中function 和 method 是有区别的，function 表示一个功能，可以独立使用，是一等公民，而 method 不能单独使用，必须由类的实例来进行调用。


