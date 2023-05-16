// import 'dart:ui';
// import 'package:flutter/cupertino.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zy_vedio/gen/assets.gen.dart';
import 'package:zy_vedio/page/camera_page/camera_page_controller.dart';
import 'package:zy_vedio/widget/t_image.dart';

class CameraPage extends StatefulWidget {

  @override
  // State<CameraPage> createState() => _CameraPageState();
  State<StatefulWidget> createState() => _CameraPageStage();

}

class _CameraPageStage extends State<CameraPage> {


  late CameraPageController _controller;


  @override
  void initState() {
    _controller = CameraPageController();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
  // return const Placeholder();
    return MaterialApp(
      home: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Obx(() {
              return _controller.cameraController == null ||
                  !_controller.cameraController!.value.isInitialized
                  ? Container(color: Colors.black)
                  : CameraPreview(_controller.cameraController!);
            })),
          Padding(padding: EdgeInsets.only(top: 38, left:19),
          child: GestureDetector(
            child: TImage(Assets.images.close.path,height: 18,width: 18),
            onTap: () {
              _controller.onCloseTap();
            },
          ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 35,right: 14),
              child: Column(
                children: [
                  // _buildIcon(Assets.images.rotate.path, '翻转', () {
                  //   _controller.onSwitchCamera()),
                  // });
                _buildIcon(Assets.images.rotate.path, '翻转', () => _controller.onSwitchCamera()),
              SizedBox(height: 16),
                  _buildIcon(Assets.images.clock.path,'倒计时', () => Future.delayed(
                      Duration(seconds: 3), () => _controller.takePhotoAndUpload())),
                  SizedBox(height: 16),
                  Obx(() => _buildIcon(_controller.flash ? Assets.images.flashOn.path : Assets.images.flashOn.path, '散光灯', () {
                    _controller.onSwitchFlash();
                  }))

                ],
              ),

            ),
          ),
          // 相册
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 62,bottom: 110),
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TImage(Assets.images.gallery.path,height: 40,width: 40),
                    SizedBox(height: 10),
                    Text('xiangce',style: TextStyle(
                      color: Colors.white,fontSize: 12,decoration: TextDecoration.none),
                    )
                  ],
                ),
                onTap: () async {
                  var pickedFile = await ImagePicker().pickVideo(
                      source: ImageSource.gallery);
                  var path = pickedFile?.path;
                  if (path != null) {
                    print("zhanyu= upload picture: $path");
                  }

                }
              ),
            ),
          ),
          Align(
             alignment: Alignment.bottomCenter,
             child: Padding(
              padding: EdgeInsets.only(bottom: 115),
              child: GestureDetector(
              onTap: () => _controller.takePhotoAndUpload(),
                child: Obx(() => Container(
                height: 75,
                width: 75,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17, horizontal: 22),
                  child: TImage(Assets.images.flashOn.path,height: 33,width: 33),
               ),
               decoration: BoxDecoration(
                 color: _controller.recording ? Colors.grey : Color(0xffff2c54),
                 borderRadius: BorderRadius.all(Radius.circular(50)),
                 border: Border.all(width: 4,color: Colors.white)
    ),
    )),
    ),
    ),
    )
        ],
      ),
    );

  }


/// 构建控制Button，图片+文本，垂直结构

  Widget _buildIcon(String iconPath, String title,GestureTapCallback? onTap) {
  return GestureDetector(
    child: Column(
        children: [
          TImage(iconPath,width: 25,height: 25,),
          Text(title,
            style: TextStyle(color: Colors.white,fontSize: 10,decoration: TextDecoration.none))
        ]),
      onTap: onTap);
  }

}
