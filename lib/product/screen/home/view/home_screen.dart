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


  @override
  Widget build(BuildContext context) {
    context.watch<AddTrimProvider>().isFetch ? context.watch<AddTrimProvider>().restoreAudios() : null;
    context.watch<AddTrimProvider>().isFetchYoutubeList ? context.watch<AddTrimProvider>().getYoutubelist() : null;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: context.watch<AddTrimProvider>().youtubeList.isNotEmpty
                ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of columns
                    crossAxisSpacing: 20.0, // Set the spacing between columns
                    mainAxisSpacing: 10.0, // Set the spacing between rows
                    childAspectRatio: 3,
                  ),
                  itemCount: context.watch<AddTrimProvider>().youtubeList.length, // Set the number of items in your list
                  itemBuilder: (context, index) {
                  return CustomAudioYoutubeComponent(youtubeList: context.watch<AddTrimProvider>().youtubeList[index], index:index);
                  },
                  )
                : const Text('Please add a sound'),
          ),
          Expanded(
            child: context.watch<AddTrimProvider>().audioListName.isNotEmpty
                ? Expanded(
            child: ListView.builder(
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
                  audioName: selectedAudio.trackname,
                  audioExplanation: selectedAudio.explanation,
                  trackName: selectedAudio.trackTitle,
                  audio: selectedAudio,
                );
              },
            ),
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
