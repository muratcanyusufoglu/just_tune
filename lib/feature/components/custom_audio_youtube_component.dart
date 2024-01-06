import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CustomAudioYoutubeComponent extends StatefulWidget {
  const CustomAudioYoutubeComponent({Key? key, required this.youtubeLink}) : super(key: key);

  final String youtubeLink;

  @override
  State<CustomAudioYoutubeComponent> createState() => _CustomAudioYoutubeComponentState();
}

class _CustomAudioYoutubeComponentState extends State<CustomAudioYoutubeComponent> {
  late YoutubePlayerController _controller;
  late bool isPlayerReady = false;
  late Future<String> videoTitleFuture = Future.value(''); // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    final String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeLink) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );

    videoTitleFuture = _fetchVideoTitle(widget.youtubeLink);
  }

  Future<String> _fetchVideoTitle(String videoId) async {
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(videoId);
    return video.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.amber[700],
      ),
        child: Row(
          children: [
        IconButton(
            onPressed: ()=> _controller.play(),
            icon:const Icon(Icons.play_circle_filled_outlined, color: Colors.red,size: 30)
          ),
        FutureBuilder<String>(
          future: videoTitleFuture,
          builder: (context, snapshot) {
            return Text(snapshot.data ?? '', style: const TextStyle(color: Colors.black),overflow: TextOverflow.fade,);
          },
        ), 
        YoutubePlayer(
          aspectRatio: 1/1,
          width: 0,
          controller: _controller,
          onReady: () {
          },
          progressColors: ProgressBarColors(playedColor: Colors.red, backgroundColor: Colors.red,bufferedColor:Colors.red, handleColor: Colors.red),
          progressIndicatorColor: Colors.red,
          liveUIColor: Colors.red,
        ),
          ],
        ),
      ),
    );
  }
}
