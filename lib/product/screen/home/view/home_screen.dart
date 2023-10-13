import 'package:drum_machine/feature/components/custom_audio_list_component.dart';
import 'package:drum_machine/feature/constants/audio_list.dart';
import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:drum_machine/product/screen/add_drim/view/add_trim.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AddTrimProvider>().isFetch ? context.watch<AddTrimProvider>().restoreAudios() : null;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
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
                        trackName: selectedAudio.trackname,
                      );
                    },
                  )
                : Container(),
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
