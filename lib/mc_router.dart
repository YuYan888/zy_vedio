import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zy_vedio/page/login_page/login_page.dart';
import 'package:zy_vedio/main.dart';
import 'package:zy_vedio/page/camera_page/camera_page.dart';
import 'package:zy_vedio/page/mine_page/mine_page.dart';
import 'package:zy_vedio/photo_picker.dart';
import 'package:zy_vedio/player_page.dart';
import 'package:zy_vedio/second_page.dart';
import 'package:zy_vedio/video_app.dart';
import 'package:zy_vedio/video_chewie.dart';
import 'package:zy_vedio/video_list/controller/public_controller.dart';

import 'gen/assets.gen.dart';
import 'video_list/video_list.dart';

class MCRouter extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  // static const String mainPage = '/main';
  static const String loginPage = '/login';

  static const String secondPage = '/second';
  static const String playerPage = '/player';
  static const String cameraPage = '/camera';

  static const String videoListPage = 'video_list';
  static const String videoAppPage = '/video';
  static const String videoChewiePage = '/video_chewie';
  static const String minePage = '/minePage';
  static const String photoPicker = '/photo_picker';
  static const String key = 'key';
  static const String value = 'value';


  static const String key_url = 'url';
  static const String key_height = 'height';
  static const String key_width = 'width';


  final List<Page> _pages = [];

  late Completer<Object?> _boolResultCompleter;

  MCRouter() {
    // _pages.add(_createPage(const RouteSettings(name: mainPage, arguments: [])));
    _pages.add(_createPage(const RouteSettings(name: loginPage, arguments: [])));

  }

  @override
  Widget build(BuildContext context) {
    return Navigator(key: navigatorKey, pages: List.of(_pages), onPopPage: _onPopPage);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {}

  @override
  Future<bool> popRoute({Object? params}) {
    if (params != null) {
      _boolResultCompleter.complete(params);
    }
    if (_canPop()) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmExit();
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    if (_canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }

  // 判断page栈长度，为空则即将退出App；不为空则返回true表示页面关闭
  bool _canPop() {
    return _pages.length > 1;
  }

  void replace({required String name, dynamic arguments}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    push(name: name, arguments: arguments);
  }

  Future<Object?> push({required String name, dynamic arguments}) async {
    _boolResultCompleter = Completer<Object?>();
    _pages.add(_createPage(RouteSettings(name: name, arguments: arguments)));
    notifyListeners();
    return _boolResultCompleter.future;
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget page;

    var args = routeSettings.arguments;

    switch (routeSettings.name) {
      // case mainPage:
      //   page = const MyHomePage(title: 'My Home Page'));
      //   break;
    case loginPage:
        page = const LoginPage();
        break;
      case secondPage:
        page = SecondPage(params: routeSettings.arguments?.toString() ?? '');
        break;
      case playerPage:
        page = PlayerPage(routeSettings.arguments?.toString() ?? '');
        break;
      case cameraPage:
        page = CameraPage();
        break;
      case videoAppPage:
        page = VideoApp(routeSettings.arguments?.toString() ?? '');
        break;
      case videoChewiePage:
        page = VideoChewie(url:routeSettings.arguments?.toString() ?? '',title: 'My cnm Page');

        break;
      case videoListPage:
        page = VideoList(PublicController());
        break;
      case minePage:
        page = MinePage();
        break;
      case photoPicker:
        String? url;
        String height = '';
        String width = '';

        if (args is Map<String, String>) {
          url = args[MCRouter.key_url];
          height = args[MCRouter.key_height] ?? height;
          width = args[MCRouter.key_width] ?? width;
        }
        page = PhotoPickerPage(url ?? Assets.images.defaultPhoto.keyName);

        break;


      default:
        page = const Scaffold();
    }
    return MaterialPage(
        child: page,
        key: Key(routeSettings.name!) as LocalKey,
        name: routeSettings.name,
        arguments: routeSettings.arguments);
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('确认退出吗'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('取消')),
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('确定'))
          ],
        );
      },
    );
    return result ?? true;
  }
}
