
import 'package:drum_machine/feature/constants/audio_list.dart';
import 'package:drum_machine/feature/components/custom_audio_list_component.dart';
import 'package:drum_machine/feature/constants/icons/app_icons.dart';
import 'package:drum_machine/feature/models/audio_list/audio_list_model.dart';
import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTrim extends StatefulWidget {
  const AddTrim({super.key});

  @override
  State<AddTrim> createState() => _AddTrimState();
}

class _AddTrimState extends State<AddTrim> {
  String clipboardContent = '';
  TextEditingController _youtubeLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initClipboardListener();
  }

  void _initClipboardListener() {
    Clipboard.getData(Clipboard.kTextPlain).then((ClipboardData? data) {
      if (data != null && data.text != null) {
        setState(() {
          clipboardContent = data.text!;
          _showClipboardPopup();
        });
      }
    });
  }

  void _showClipboardPopup() {
    // Show your popup here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('We Observed a Youtube Link', style: Theme.of(context).textTheme.titleLarge),
          content: Text('Do you want to add this youtube link your sound?', style: Theme.of(context).textTheme.bodySmall),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(onPressed: () async{
            _youtubeLinkController.text = clipboardContent;
            Navigator.pop(context);
            _showYoutubeLinkModal(context,_youtubeLinkController);
          }, child: const Text('Add Youtube Link'))          
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Add Sounds', style: Theme.of(context).textTheme.titleMedium,), backgroundColor: Theme.of(context).colorScheme.background,),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            _showYoutubeLinkModal(context, _youtubeLinkController);
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
      // floatingActionButton: FloatingActionButton.extended(
      //   heroTag: 'uniqueTag',
      //   label: const Row(
      //     children: [Icon(Icons.save), Text('Save')],
      //   ),
      //   onPressed: () {},
      // ),
    );
  }

  Future<dynamic> _showYoutubeLinkModal(BuildContext context, TextEditingController youtubeLinkController) {
    return showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add Youtube Link'),
                      ElevatedButton(
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Open Youtube'), AppIcons.youtubeIcon]),
                        onPressed: () => context.read<AddTrimProvider>().openYouTubeApp(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                        controller: youtubeLinkController,  
                        decoration: const InputDecoration(                          
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Youtube Link',
                        ),
                        maxLines: 1, 
                        onChanged: (value) => setState(() {
                          youtubeLinkController.text = value;
                        })),
                      ),
                      ElevatedButton(
                        child: const Text('Save Link'),
                        onPressed: () => {context.read<AddTrimProvider>().addAndStoreYoutubeMusics(youtubeLinkController.text, context)},
                      ),
                    ],
                  ),
                ),
              ),
            );
    },);
  }
}
