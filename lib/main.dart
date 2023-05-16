import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zy_vedio/mc_router.dart';
import 'page/login_page/login_page.dart';
void main() {
  runApp(const MyApp());
  // runApp(const LoginPage());

}

MCRouter router = MCRouter();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(//router第一个页面添加的是login
        routerDelegate: router,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}



