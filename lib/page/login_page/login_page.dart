
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:zy_vedio/page/mine_page/mine_page.dart';
import 'package:zy_vedio/widget/t_image.dart';
import 'package:flutter/cupertino.dart';
import '../../gen/assets.gen.dart';
import '../../main.dart';
import '../../mc_router.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_service.dart';

TextEditingController _phone = TextEditingController();
TextEditingController _pass = TextEditingController();

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '登录',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width; //屏幕宽度
    // double sh = MediaQuery.of(context).size.height; //屏幕高度
   print("sw====${sw}");
    final wordPair = new WordPair.random();
    return Scaffold(
          // appBar: AppBar(
          //   title: Text('登录'),
          // ),
          body: new ListView(children: <Widget>[
            logoView(),
            // textview(),
            endtitext(),
            password(),
            button()
          ]));
  }

}

class logoView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width; //屏幕宽度

    return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: TImage(
              Assets.images.imgApplogo.path,
              height: 0.61 * sw * 0.8,
              width: sw  * 0.8,
              fit: BoxFit.fill),
        ),
    );
  }
}


class endtitext extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SizedBox(
          width: 300.0,
          child: new TextField(
            // inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
            maxLength: 11, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
            maxLines: 1, //最大行数
            decoration: InputDecoration(
              labelText: '请输入手机号',
              //设置输入框前面有一个电话的按钮 suffixIcon
              prefixIcon: Icon(Icons.phone),
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            //绑定控制器
            controller: _phone,
            //内容改变的回调
            onChanged: (value) {
              StepState() {
                _phone.text = value;
              }
            },
          )),
    );
  }
}


class password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SizedBox(
        width: 300.0,
        child: new TextField(
          maxLength: 6, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
          maxLines: 1, //最大行数
          obscureText: true, //是否是密码
          decoration: InputDecoration(
              labelText: '请输入密码',
              prefixIcon: Icon(Icons.lock_outline),
              labelStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              )),
          controller: _pass,
          onChanged: (value) {
            StepState() {
              _pass.text = value;
            }
          },
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[

    // “RaisedButton”已弃用，不应使用,请改用ElevatedButton
        ElevatedButton(
          child: Text('登录'),
          onPressed: () async {
            print(_phone.text);
            print(_pass.text);

            /// 发起网络接口请求
            LoginService().login().then((value) => {
              print("value-----------${value}")
            }
            );

            // Map result = await request('/api/user/login',
            //     data: {'account': _phone.text, 'password': _pass.text});
            // if (result != null) {
            //   router.push(name: MCRouter.minePage, arguments: 'Hello from mainPage');
            // }

            // var response = await Dio().get(
            //     "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
            //     options: Options(responseType: ResponseType.bytes));
            // final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: "hello");
            // print("result: $result");

            if (_phone.text == '1234' && _pass.text == '123') {
              print('密码正确，去登录');
              // router.push(name: MCRouter.minePage, arguments: 'Hello from mainPage');

            } else {
              print('账号或密码错误');
            }
          },
        ),
      ],
    );
  }
}