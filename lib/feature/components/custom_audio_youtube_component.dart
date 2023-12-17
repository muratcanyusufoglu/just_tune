import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomAudioYoutubeComponent extends StatefulWidget {
  const CustomAudioYoutubeComponent({super.key, required this.youtubeLink});

  final String youtubeLink;
  @override
  State<CustomAudioYoutubeComponent> createState() => _CustomAudioYoutubeComponentState();
}

class _CustomAudioYoutubeComponentState extends State<CustomAudioYoutubeComponent> {
  late YoutubePlayerController _controller;

  @override
void initState(){
    final String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeLink) ?? '';
    print('videoId');
    print(videoId);
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
        ),
    );
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          YoutubePlayer(
                        aspectRatio : 5 / 5,
            width: 20,
       controller: _controller,
       onReady: () {
          print('Playerrrrrrr issssss readddddddyyyy');
       },
    ),
    ElevatedButton(onPressed: (){_controller.play();}, child: Text('playyyyyyy', style: TextStyle(color:Colors.red),)),
        ],
    );
  }
}
