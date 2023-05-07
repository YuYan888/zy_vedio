
import 'package:zy_vedio/video_list/controller/video_controller.dart';
import 'package:zy_vedio/video_list/server_data.dart';

class FavoriteController extends VideoController {
  @override
  String get spKey => 'favorite_video';

  @override
  // TODO: implement videoData
  String get videoData => ServerData.fetchFavoriteFromServer();
  
}