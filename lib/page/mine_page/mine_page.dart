import 'package:flutter/cupertino.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

/**
 * 状态保持一般都会说要加 SingleTickerProviderStateMixin 或AutomaticKeepAliveClientMixin
 */

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin{
  static const image_height = 138.5;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
