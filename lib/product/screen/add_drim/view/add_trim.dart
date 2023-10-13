
import 'package:drum_machine/feature/constants/audio_list.dart';
import 'package:drum_machine/feature/components/custom_audio_list_component.dart';
import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:flutter/material.dart';

class AddTrim extends StatelessWidget {
  const AddTrim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: AudioList().audioList.length,
              itemBuilder: (context, index) {
                if (index == AudioList().audioList.length) return null;
                final Audio audio = AudioList().audioList[index];
                return CustomAudioListComponent(
                  audioName: audio.trackname,
                  audioExplanation: audio.explanation,
                  trackName: audio.trackTitle,
                  audio: audio,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        label: const Row(
          children: [Icon(Icons.save), Text('Save')],
        ),
        onPressed: () {},
      ),
    );
  }
}
