
import 'package:drum_machine/feature/constants/audio_list.dart';
import 'package:drum_machine/feature/components/custom_audio_list_component.dart';
import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTrim extends StatelessWidget {
  const AddTrim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            showModalBottomSheet(context: context, builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      TextField(onChanged: (value) => context.read<AddTrimProvider>().setYoutubeMelody(value)),
                      ElevatedButton(
                        child: const Text('Save Link'),
                        onPressed: () => {context.read<AddTrimProvider>().addAndStoreYoutubeMusics(context.read<AddTrimProvider>().youtubeMelody), Navigator.pop(context)},
                      ),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },);
          }, child: const Text('Add Youtube Link')),
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
