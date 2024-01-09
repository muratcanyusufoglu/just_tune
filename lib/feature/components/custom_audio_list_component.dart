import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class CustomAudioListComponent extends StatelessWidget {
  CustomAudioListComponent({super.key, required this.audioName, required this.audioExplanation, required this.trackName, required this.audio});

  final String audioName;
  final String audioExplanation;
  final String trackName;
  final Audio audio;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await player.stop();
        final String track = 'assets/$trackName';
        await player.setAsset(track);
        await player.play();
      },
      onLongPress: () {
      },
      child: SizedBox(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.music_note),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audioExplanation,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AddTrimProvider>().addAndStoreTask(audio);
                  },
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(8),
                    child: context.watch<AddTrimProvider>().isSoundSelected(audio)
                        ? const Icon(
                            Icons.check_box_rounded
                          )
                        : const Icon(
                          Icons.check_box_outline_blank
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
