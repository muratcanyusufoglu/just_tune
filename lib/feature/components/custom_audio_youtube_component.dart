import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CustomAudioYoutubeComponent extends StatefulWidget {
  const CustomAudioYoutubeComponent({Key? key, required this.youtubeLink, required this.deleteLink}) : super(key: key);

  final String youtubeLink;
  final void Function(String) deleteLink;

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
    bool linkIsShort = videoId.contains('feature=share') ? true : false;
    if(linkIsShort){
    var link = videoId.split('?feature=share');
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(link[0]);
    return video.title;
  }
  else{
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(videoId);
    return video.title;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.amber[700],
    ),
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
              onPressed: ()=> {},
              icon: Icon(Icons.play_circle_filled_outlined, color:_controller.value.isPlaying ? Colors.white : Colors.red,size: 30)
            ),
        ),
        Expanded(
          flex:3,
          child: FutureBuilder<String>(
            future: videoTitleFuture,
            builder: (context, snapshot) {
              return Text(snapshot.data ?? '', style: const TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,);
            },
          ),
        ), 
        showDeleteIcon ? Expanded(flex:1, child: IconButton(
              onPressed: () => widget.deleteLink(widget.youtubeLink),
              icon: const Icon(Icons.delete, color: Colors.white,size: 30)
            ),) : Container(),
        Expanded(
          flex:0,
          child: YoutubePlayer(
            aspectRatio: 1/1,
            width: 0,
            controller: _controller,
          ),
        ),
          ],
        ),
      ),
    );
  }
}
