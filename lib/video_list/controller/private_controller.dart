
import 'package:zy_vedio/video_list/controller/video_controller.dart';

import '../server_data.dart';

class PrivateController extends VideoController {
  @override
  String get spKey => 'private_video';

  @override
  String get videoData => ServerData.fetchPrivateFromServer();
}