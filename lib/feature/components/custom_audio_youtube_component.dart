import 'package:drum_machine/feature/constants/icons/app_icons.dart';
import 'package:drum_machine/feature/functions/color_function.dart';
import 'package:drum_machine/feature/models/youtube_list/youtube_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomAudioYoutubeComponent extends StatefulWidget {
  const CustomAudioYoutubeComponent({Key? key, required this.youtubeList, required this.index}) : super(key: key);
  final YoutubeList youtubeList;
  final int index;

  @override
  State<CustomAudioYoutubeComponent> createState() => _CustomAudioYoutubeComponentState();
}

class _CustomAudioYoutubeComponentState extends State<CustomAudioYoutubeComponent> {
  late YoutubePlayerController _controller;
  late bool isPlayerReady = false;
  late Future<String> videoTitleFuture = Future.value(''); // Initialize with an empty string
  bool showDeleteIcon = false;

  @override
  void initState() {
    super.initState();
    final String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeList.youtubeLink) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: SelectedColor().returnColorFromIndex(widget.index+1)),
      child: TextButton(
        onPressed: ()=> _controller.play(),
        onLongPress: () async {
        HapticFeedback.mediumImpact();    
        setState(() {
          showDeleteIcon = true;
        });    
      },
      child: Row(
          children: [
        Expanded( 
          flex:1,
          child: IconButton(
              onPressed: ()=> _controller.play(),
              icon: AppIcons.youtubeIcon
            ),
        ),
        Expanded(
          flex:3,
          child: Text(widget.youtubeList.title ?? '', style: const TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,)        
        ), 
        showDeleteIcon ? Expanded(flex:1, child: IconButton(
              onPressed: () => context.read<AddTrimProvider>().deleteLinkToBox(widget.youtubeList.youtubeLink, context),
              icon: const Icon(Icons.delete, color: Colors.white,size: 30)
            ),) : Container(),
        YoutubePlayer(
          aspectRatio: 1/1,
          width: 0,
          controller: _controller,
        ),
          ],
        ),
      ),
    );
  }
}
