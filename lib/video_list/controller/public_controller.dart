
import 'package:zy_vedio/video_list/controller/video_controller.dart';
import 'package:zy_vedio/video_list/server_data.dart';

class PublicController extends VideoController {
  @override
  // TODO: implement spKey
  String get spKey => 'public_video';

  @override
  // TODO: implement videoData
  String get videoData => ServerData.fetchDataFromServer();

}