import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum LinkStrings { first, second;
  String getString() {
    switch (this) {
      case LinkStrings.first: return "?feature=share";
      case LinkStrings.second: return "?si=";
    }
  }
}


class LinkValidation{

  Future<String> validateLink(String link) async{
    bool linkIsShort = link.contains(LinkStrings.first.getString()) ? true : false;
    bool linkIsShortShare = link.contains(LinkStrings.second.getString()) ? true : false;

    if(linkIsShort){
    var result = link.split(LinkStrings.first.getString());
    return result[0];
    }
    else if(linkIsShortShare){
    var result = link.split(LinkStrings.second.getString());
    return result[0];
    }
    return link;
  }

  Future<String> validateLinkTitle(String link) async{
  bool linkIsShort = link.contains(LinkStrings.first.getString()) ? true : false;
  bool linkIsShortShare = link.contains(LinkStrings.second.getString()) ? true : false;
  var ytExplode = YoutubeExplode();

  if(linkIsShort){
    var result = link.split(LinkStrings.first.getString());
    var video = await ytExplode.videos.get(result[0]);
    return video.title;
  }
  else if(linkIsShortShare){
    var result = link.split(LinkStrings.second.getString());
    var video = await ytExplode.videos.get(result[0]);
    return video.title;
    }
  else{
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(link);
    return video.title;
  }
  }
}