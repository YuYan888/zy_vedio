import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';
import 'package:zy_vedio/video_list/controller/video_controller.dart';

import '../right_menu.dart';
import '../main.dart';
import '../mc_router.dart';
import 'package:fijkplayer/fijkplayer.dart';

class VideoList extends StatefulWidget {

  final VideoController controller;

  VideoList(this.controller);

  @override
  State<StatefulWidget> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.init().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            // itemCount: 15,
            itemCount: widget.controller.dataList?.length,
            itemBuilder: (context, index) {
              // 实际羡慕中， 通过dateList[index]取出url
              // var url = 'https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv';
              return GestureDetector(
                child: widget.controller.dataList == null
                  ? Container() // 加载提示或者骨架屏
                  : Container(
                  decoration: BoxDecoration(border: Border.all(color: const Color(0xfffef5ff),width: 0)),
                  child: Stack(
                    children: [
                      AbsorbPointer(//吸收指针事件的小部件
                          absorbing: true,
                          child: VideoView(
                              Player()
                              ..setLoop(0)
                            ..setCommonDataSource(widget.controller.dataList![index].url,
                                type: SourceType.net,autoPlay: true),
                              )),
                      Padding(padding: const EdgeInsets.only(bottom: 10,left: 15),
                      child: Row(
                        children: [
                          Text(widget.controller.count.toString(),
                          style: TextStyle(color: Colors.white,fontSize: 12))
                        ],
                      ),
                      )
                    ],
                  ),

                ),
                // onTap: () async => await router.push(name: MCRouter.videoChewiePage, arguments: widget.controller.dataList![index].url),
                // onTap: () async => await router.push(name: MCRouter.videoAppPage, arguments: widget.controller.dataList![index].url),
                onTap: () async => await router.push(name: MCRouter.playerPage, arguments: widget.controller.dataList![index].url),
              );
            })
    );
  }
}
