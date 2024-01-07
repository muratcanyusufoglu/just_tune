import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../feature/models/audio_list/audio_list_model.dart';

class AddTrimProvider extends ChangeNotifier {
  final bool _isAudioSelect = false;
  get isAudioSelect => _isAudioSelect;

  final String _audioIndex = '';
  String get audioIndex => _audioIndex;

  String _youtubeMelody = '';
  String get youtubeMelody => _youtubeMelody;

  String _youtubeLinkTitle = '';
  String get youtubeLinkTitle => _youtubeLinkTitle;

  bool _isFetch = true;
  bool get isFetch => _isFetch;

  bool _isFetchYoutubeList = true;
  bool get isFetchYoutubeList => _isFetchYoutubeList;

  bool _isSelected = true;
  bool get isSelected => _isSelected;

  final List<Audio> _audiolist = [];
  List<Audio> get audioList => _audiolist;

  final List<String> _audiolistName = [];
  List<String> get audioListName => _audiolistName;

  final List<String> _youtubeList = [];
  List<String> get youtubeList => _youtubeList;

  var box = Hive.box('audioBox');

  void setYoutubeMelody(String sound){
    _youtubeMelody = sound;
    notifyListeners();
  }

  void setYoutubeVideoTitle(String sound){
    _youtubeLinkTitle = sound;
    notifyListeners();
  }

  void addAndStoreTask(Audio audio) async {
    if (_audiolistName.contains(audio.trackTitle)) {
      _audiolistName.remove(audio.trackTitle);
    } else {
      _audiolistName.add(audio.trackTitle);
    }
    await box.put('audios', _audiolistName); // adding list of maps to storage
    _isFetch = false;
    notifyListeners();
  }
  void addLinkToBox(String audio, BuildContext context) async {
    try{
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(audio);
    if(video.duration!.inSeconds > 20){
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'On Snap!', 'This is a long video.', ContentType.failure);
    }
    else{
    if (_youtubeList.contains(audio)) {
      //_youtubeList.remove(audio);
      showSnackBar(context, 'Video already added', 'Video sound already added.', ContentType.warning);
    } else {
      _youtubeList.add(audio);
      showSnackBar(context, 'Very well', 'Video sound added.', ContentType.success);
    }
    await box.put('youtubeList', _youtubeList); // adding list of maps to storage
    _isFetchYoutubeList = false;
    notifyListeners();
    }
    }
    catch(error){
      // ignore: use_build_context_synchronously
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'On Snap!', 'This is not a youtube video link', ContentType.warning);
    }
  }

  void addAndStoreYoutubeMusics(String audio, BuildContext context) async {
    bool linkIsShort = audio.contains('feature=share') ? true : false;
    if(linkIsShort){
    var link = audio.split('?feature=share');
      addLinkToBox(link[0], context);
    }
    else{      
      addLinkToBox(audio, context);
    }
    }

  void restoreAudios() {
    List aa = box.get('audios') ?? []; // initializing list from storage
    for (int i = 0; i < aa.length; i++) {
      _audiolistName.add(aa[i]);
    }
    _isFetch = false;
  }


  void getYoutubelist() {
    List aa = box.get('youtubeList') ?? []; // initializing list from storage
    for (int i = 0; i < aa.length; i++) {
      _youtubeList.add(aa[i]);
    }
    _isFetchYoutubeList = false;
  }



  bool isSoundSelected(Audio audio) {
    if (_audiolistName.contains(audio.trackTitle)) {
      return true;
    } else {
      return false;
    }
  }

  // looping through your list to see whajmkts inside
  void printTasks() {
    for (final task in _audiolist) {
      print(task.toString());
    }
  }

  void clearTasks() {
    _audiolist.clear();
    //storageList.clear();
    box.clear();
  }

  void showSnackBar(BuildContext context, String title, String message, ContentType contentType) {
  Navigator.pop(context);
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
      inMaterialBanner: true,
    ),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

}
