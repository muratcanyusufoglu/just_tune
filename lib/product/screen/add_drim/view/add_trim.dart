
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            showModalBottomSheet(context: context, builder: (BuildContext context) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add Youtube Link'),
                      ElevatedButton(
                        child: const Text('Open Youtube App'),
                        onPressed: () => context.read<AddTrimProvider>().openYouTubeApp(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(decoration: const InputDecoration(
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Youtube Link',
      ),maxLines: 1, onChanged: (value) => context.read<AddTrimProvider>().setYoutubeMelody(value)),
                      ),
                      ElevatedButton(
                        child: const Text('Save Link'),
                        onPressed: () => {context.read<AddTrimProvider>().addAndStoreYoutubeMusics(context.read<AddTrimProvider>().youtubeMelody, context)},
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
