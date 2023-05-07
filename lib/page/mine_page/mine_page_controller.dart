import 'package:get/get.dart';
import 'package:zy_vedio/mc_router.dart';
import '../../gen/assets.gen.dart';
import 'package:zy_vedio/mc_router.dart';

import '../../main.dart';

// GetX改造步骤2：创建controller，继承自GetXController
class MinePageController extends GetxController {
  // GetX改造步骤3：给变量值添加.obs
  //背景图片url
  var _backgroundUrl = Assets.images.img.path.obs;
  var _avatarUrl = Assets.images.avatar.path.obs;

  String get backgroundUrl => _backgroundUrl.value;
  set backgroundUrl(String url) => _backgroundUrl.value = url;


  String get avatarUrl => _avatarUrl.value;
  set avatarUrl(String url) => _avatarUrl.value = url;

  var _name = 'James'.obs;
  var _uid = '88888888'.obs;

  String get name => _name.value;

  String get uidDesc => '慕课号：${_uid.value}';
 //模拟网络拉取
  String get likeCount => '23万';

  String get focusCount => '85224';

  String get followCount => '12345';


  Future<void> onTapBackground() async {

    var fileUrl = await router.push(name: MCRouter.photoPicker, arguments: {MCRouter.key_url: backgroundUrl});

    //增加类型判断

    if (fileUrl is String) {
      backgroundUrl = fileUrl;
    }
  }

  Future<void> onTapAvatar() async {

    var fileUrl = await router.push(name:MCRouter.photoPicker, arguments: {MCRouter.key_url: avatarUrl});

    if (fileUrl is String) {
      avatarUrl = fileUrl;

    }
  }

}