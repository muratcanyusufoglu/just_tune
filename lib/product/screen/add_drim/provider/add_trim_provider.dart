import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:drum_machine/feature/components/snack_bar.dart';
import 'package:drum_machine/feature/constants/app_strings.dart';
import 'package:drum_machine/feature/functions/validate_link_class.dart';
import 'package:drum_machine/feature/models/youtube_list/youtube_list_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../feature/models/audio_list/audio_list_model.dart';

class AddTrimProvider extends ChangeNotifier {
  final bool _isAudioSelect = false;
  get isAudioSelect => _isAudioSelect;

  final String _audioIndex = '';
  String get audioIndex => _audioIndex;

  String _youtubeMelody = '';
  String get youtubeMelody => _youtubeMelody;

  bool _isFetch = true;
  bool get isFetch => _isFetch;

  bool _isFetchYoutubeList = true;
  bool get isFetchYoutubeList => _isFetchYoutubeList;

  final List<Audio> _audiolist = [];
  List<Audio> get audioList => _audiolist;

  final List<String> _audiolistName = [];
  List<String> get audioListName => _audiolistName;

  final List<YoutubeList> _youtubeList = [];
  List<YoutubeList> get youtubeList => _youtubeList;


  var box = Hive.box('audioBox');

  void setYoutubeMelody(String sound){
    _youtubeMelody = sound;
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

void deleteLinkToBox(String youtubeLink, BuildContext context) async {
  List<YoutubeList> list = [];
  if (_youtubeList.any((youtube) => youtube.youtubeLink == youtubeLink)) {
    _youtubeList.removeWhere((youtube) => youtube.youtubeLink == youtubeLink);
    list.addAll(_youtubeList);
    _youtubeList.clear();
    _youtubeList.addAll(list);
    await box.put('youtubeList', _youtubeList.map((youtube) => youtube.toJson()).toList());
    notifyListeners();
  }
}

void addLinkToBox(String audio, BuildContext context) async {
  try {
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(audio);
    if (video.duration!.inSeconds > 100) {
        ShowSnackBar().showSnackBar(context, AppStrings.ohSnap, AppStrings.thisIsLongVideo, ContentType.failure);
    } else {
      if (_youtubeList.any((youtube) => youtube.title == audio)) {
        ShowSnackBar().showSnackBar(context, AppStrings.videoAlreadyAdded, AppStrings.videoSoundAlreadyAdded, ContentType.warning);
      } else {
        String videoTitle = await LinkValidation().validateLinkTitle(audio);
        _youtubeList.add(YoutubeList(index: UniqueKey().toString(), title: videoTitle, duration: video.duration.toString(), youtubeLink: audio));
        ShowSnackBar().showSnackBar(context, AppStrings.veryWell, AppStrings.videoSoundAdded, ContentType.success);
      }
      await box.put('youtubeList', _youtubeList.map((youtube) => youtube.toJson()).toList());
      _isFetchYoutubeList = false;
      notifyListeners();
    }
  } catch (error) {
    ShowSnackBar().showSnackBar(context, AppStrings.ohSnap, AppStrings.thisIsNotaYoutubeVideoLink, ContentType.warning);
  }
}

  void addAndStoreYoutubeMusics(String audio, BuildContext context) async {
    addLinkToBox(await LinkValidation().validateLink(audio), context);
  }

  void restoreAudios() {
    List aa = box.get('audios') ?? []; // initializing list from storage
    for (int i = 0; i < aa.length; i++) {
      _audiolistName.add(aa[i]);
    }
    _isFetch = false;
  }

void getYoutubelist() {
  List<YoutubeList> youtubeList = [];
  // Retrieve the raw data as List<dynamic> from the box
  List<dynamic>? rawList = box.get('youtubeList');

  // Ensure that rawList is not null before attempting to convert
  if (rawList != null) {
    // Convert the raw data to a list of YoutubeList objects
    youtubeList = YoutubeList.fromJsonList(rawList);
  }
  _youtubeList.clear(); // Clear the existing list
  for (int i = 0; i < youtubeList.length; i++) {
    YoutubeList youtubeListData = youtubeList[i];
    _youtubeList.add(youtubeListData);
  }
  _isFetchYoutubeList = false;
  notifyListeners();
}



bool isSoundSelected(Audio audio) {
    if (_audiolistName.contains(audio.trackTitle)) {
      return true;
    } else {
      return false;
    }
  }

void openYouTubeApp() async {
  String youtubeChannelUrl = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
  String youtubeAppUrl = 'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';

  if (Platform.isIOS) {
    if (await canLaunch(youtubeAppUrl)) {
      await launch(youtubeAppUrl, forceSafariVC: false);
    } else {
      if (await canLaunch('$youtubeChannelUrl')) {
        await launch('$youtubeChannelUrl');
      } else {
        throw 'Could not launch $youtubeChannelUrl';
      }
    }
  } else {
    String url = youtubeChannelUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }}
}
