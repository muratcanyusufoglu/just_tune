import 'package:drum_machine/feature/components/custom_audio_list_component.dart';
import 'package:drum_machine/feature/components/custom_audio_youtube_component.dart';
import 'package:drum_machine/feature/constants/audio_list.dart';
import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:drum_machine/product/screen/add_drim/view/add_trim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController _controller;

  @override
void initState(){
    _controller = YoutubePlayerController(
        initialVideoId: 'OcEi2o8g2L0',
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
        ),
    );
    super.initState();
}
  @override
  Widget build(BuildContext context) {

    context.watch<AddTrimProvider>().isFetch ? context.watch<AddTrimProvider>().restoreAudios() : null;
    context.watch<AddTrimProvider>().isFetchYoutubeList ? context.watch<AddTrimProvider>().getYoutubelist() : null;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          YoutubePlayer(
            aspectRatio : 5 / 5,
            width: 4,
       controller: _controller,
       onReady: () {
          print('Player is ready.');
       },
       
    ),
    ElevatedButton(onPressed: (){_controller.play();}, child: Text('playyyyyyy')),
          Expanded(
            child: context.watch<AddTrimProvider>().audioListName.length > 0
                ? ListView.builder(
                    itemCount: context.watch<AddTrimProvider>().audioListName.length,
                    itemBuilder: (context, index) {
                      Audio selectedAudio = AudioList().audioList[index];
                      for (var i = 0; i < AudioList().audioList.length; i++) {
                        final Audio audio = AudioList().audioList[i];
                        if (context.read<AddTrimProvider>().audioListName[index] == audio.trackTitle) {
                          selectedAudio = AudioList().audioList[i];
                        }
                      }
                      return CustomAudioListComponent(
                        audio: selectedAudio,
                        audioName: selectedAudio.trackname,
                        audioExplanation: selectedAudio.explanation,
                        trackName: selectedAudio.trackTitle,
                      );
                    },
                  )
                : const Text('Please add a sound'),
          ),
          Expanded(
            child: context.watch<AddTrimProvider>().youtubeList.length > 0
                ? ListView.builder(
                    itemCount: context.watch<AddTrimProvider>().youtubeList.length,
                    itemBuilder: (context, index) {
                      // for (var i = 0; i < AudioList().audioList.length; i++) {
                      //   final Audio audio = AudioList().audioList[i];
                      //   if (context.read<AddTrimProvider>().audioListName[index] == audio.trackTitle) {
                      //     selectedAudio = AudioList().audioList[i];
                      //   }
                      // }
                      return CustomAudioYoutubeComponent(youtubeLink: context.read<AddTrimProvider>().youtubeList[index],);
                    },
                  )
                : const Text('Please add a sound'),
          ),
        ],
      ),
      floatingActionButton: _actionButton(context),
    );
  }

  FloatingActionButton _actionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTrim(),
            ));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_music),
          Icon(
            Icons.add,
            size: 15,
          )
        ],
      ),
    );
  }
}
