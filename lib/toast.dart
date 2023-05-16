import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 * 封装 fluttertoast
 * Toast.showHud("测试"); // Toast 白色主题
 *  Toast.showHud("测试", type: ToastType.black); // Toast 黑色主题
 *  Toast.showLoding(context, userInteraction: true) // loding 白色主题 userInteraction 是否允许交互
 *  Toast.showLoding(context, userInteraction: true, type: ToastType.black); // loding 黑色主题
 *  /// isRealTime: 是否立即显示 ture立即显示 false 是延迟加载的 注意:在initState中方法调用必须为false 不然会出问题
 *  Toast.showLoding(context, userInteraction: true, type: ToastType.black, isRealTime: false); // loding 黑色主题
 */

enum ToastType {
  white, // 白色
  black, // 黑色
}

class Toast {

  static const defaultType = ToastType.white; // 默认样式
  /// 显示Toast
  /// msg: 显示内容
  /// type: 样式
  static void showHud(String msg, {ToastType type = defaultType}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        gravity: Platform.isIOS ? ToastGravity.CENTER : ToastGravity.BOTTOM, // iOS显示在中间 安卓显示在底部
        backgroundColor: type == ToastType.black ? Colors.black : Colors.white,
        textColor: type == ToastType.black ? Colors.white : Colors.black,
        fontSize: 16.0);
  }

  /// 取消Toast
  static void dismiss() {
    Fluttertoast.cancel();
    if (RealTimeLoadingDialog.isShow()) {
      RealTimeLoadingDialog.dismiss();
    }
    if (LoadingDialog.isShow()) {
      LoadingDialog.dismiss();
    }
  }

  /// 显示loding
  /// BuildContext context
  /// msg: 显示内容
  /// userInteraction: 是否允许交互
  /// type: 样式
  /// isRealTime: 是否立即显示 ture立即显示 false 是延迟加载的 注意:在initState中方法调用必须为false 不然会出问题
  static void showLoading(BuildContext context,
      {String msg = "",
        bool userInteraction = false,
        ToastType type = _defaultType,
        bool isRealTime = true}) {
    dismiss();
    if (isRealTime) {
      RealTimeLoadingDialog.showLoading(context,
          content: msg, userInteraction: userInteraction, type: type);
    } else {
      LoadingDialog.showLoading(context,
          content: msg, userInteraction: userInteraction, type: type);
    }
  }

  ///加载弹框
  class LoadingDialog {
  static Timer _timer; // 超时定时器
  static ToastType _type;
  static OverlayEntry itemEntry;
  // 是否显示
  static  bool _isShow = false;

  /// 展示
  /// BuildContext context
  /// content 显示内容
  /// userInteraction 是否允许交互 默认不允许
  static void showLoading(BuildContext context,
  {String content = "数据加载中...",
  bool userInteraction = false,
  ToastType type}) async {
  dismiss();
  _type = type;
  _isShow = true;
  ///显示悬浮menu
  itemEntry = OverlayEntry(
  builder: (BuildContext context) => _Loading(
  userInteraction: userInteraction,
  child: _contentView(content),
  ));
  _startTimer();
  WidgetsBinding.instance.addPostFrameCallback((_) {
  Overlay.of(context)?.insert(itemEntry);
  });
  }

  /// loding 是否显示
  static bool isShow() {
  return _isShow;
  }

  ///隐藏
  static void dismiss() {
  if (!_isShow) return;
  var tmp = itemEntry?.mounted;
  if (tmp == false) {
  Future.delayed(Duration(milliseconds: 3), () {
  dismiss();
  });
  return;
  }
  _cleanData();
  _isShow = false;
  }

  static _cleanData() {
  itemEntry?.remove();
  itemEntry = null;
  _stopTimer();
  }

  /// 内容View
  static _contentView(String content) {
  return _loadingContentView(_type, content);
  }

  /// 开始定时
  static _startTimer() {
  _timer = Timer(Duration(seconds: 60), () {
  // 60秒超时时间 自动消失
  LoadingDialog.dismiss();
  });
  }

  /// 销户定时
  static _stopTimer() {
  _timer?.cancel();
  _timer = null;
  }
  }


  /// 实时加载弹框
  class RealTimeLoadingDialog {
  static Timer _timer; // 超时定时器
  static BuildContext _context; // 理论上只有一个 不然就可以用一个数组保存
  static ToastType _type;

  /// 展示
  /// BuildContext context
  /// content 显示内容
  /// userInteraction 是否允许交互 默认不允许
  static void showLoading(BuildContext context,
  {String content = "数据加载中...",
  bool userInteraction = false,
  ToastType type}) async {
  LoadingDialog.dismiss(); // 如果之前有显示取消显示
  if (_context == null) {
  _context = context;
  _type = type;
  var child = _contentView(content);
  _LoadingRoute _route = _LoadingRoute(
  child: _Loading(
  userInteraction: userInteraction,
  child: child,
  ),
  );
  Future.delayed(Duration.zero, () {
  // 必须添加 因为请求是异步等待的 async await
  Navigator.push(
  context,
  _route
  );
  });
  _startTimer();
  }
  }

  /// loading 是否显示
  static bool isShow() {
  return _context==null?false:true;
  }

  ///隐藏
  static void dismiss() {
  if (_context == null) return;
  _stopTimer();
  Navigator.of(_context).pop();
  _context = null;
  }

  /// 内容View
  static _contentView(String content) {
  return _loadingContentView(_type, content);
  }

  /// 开始定时
  static _startTimer() {
  _timer = Timer(Duration(seconds: 60), () {
  // 60秒超时时间 自动消失
  RealTimeLoadingDialog.dismiss();
  });
  }

  /// 销户定时
  static _stopTimer() {
  if (_timer == null) return;
  _timer?.cancel();
  _timer = null;
  }
  }


  ///Widget
  class _Loading extends StatelessWidget {
  final Widget child;

  final bool userInteraction;

  _Loading({Key key, @required this.child, this.userInteraction = false})
      : assert(child != null),
  super(key: key);

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
  onTap: () {
  if (userInteraction == false) return;
  LoadingDialog.dismiss();
  },
  child: Material(
  color: Colors.black12,
  child: Center(
  child: child,
  )));
  }
  }

  ///Route
  class _LoadingRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _LoadingRoute({@required this.child});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
  Animation<double> secondaryAnimation) {
  return child ?? Container();
  }

  @override
  Duration get transitionDuration => _duration;
  }

  Widget _loadingContentView(ToastType _type, String content, {Widget midView}) {
  if (midView == null) midView = _progress(_type);
  var contentView = Row(
  children: [
  Expanded(child: Container()),
  Container(
  decoration: BoxDecoration(
  color: _type == ToastType.black
  ? Color(0xFF252525).withOpacity(0.6)
      : Colors.white,
  borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.all(30),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [midView, _label(content, _type)],
  ),
  ),
  Expanded(child: Container())
  ],
  );
  return Column(
  children: [
  Expanded(child: Container()),
  contentView,
  Expanded(child: Container()),
  ],
  );
  }

  _progress(ToastType _type) {
  return Container(
  width: 28,
  height: 28,
  child: Theme(
  data: ThemeData(
  cupertinoOverrideTheme: CupertinoThemeData(
  // 菊花
  brightness:
  _type == ToastType.black ? Brightness.dark : Brightness.light,
  ),
  ),
  child: CupertinoActivityIndicator(
  radius: 14,
  ),
  ),
  );
  }

  _label(String content, ToastType _type) {
  if (content.length == 0)
  return Container();
  else {
  return Container(
  margin: EdgeInsets.only(top: 15),
  child: ConstrainedBox(
  constraints: BoxConstraints(
  maxWidth: 250,
  ),
  child: Text(
  content,
  overflow: TextOverflow.ellipsis,
  softWrap: true,
  maxLines: 5,
  style: TextStyle(
  fontSize: 16,
  color: _type == ToastType.black ? Colors.white : Colors.black,
  ),
  ),
  ));
  }
  }