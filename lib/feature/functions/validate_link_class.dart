import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LinkValidation{

  Future<String> validateLink(String link) async{
    bool linkIsShort = link.contains('feature=share') ? true : false;
    bool linkIsShortShare = link.contains('?si=') ? true : false;

    if(linkIsShort){
    var result = link.split('?feature=share');
    return result[0];
    }
    else if(linkIsShortShare){
    var result = link.split('?si=');
    return result[0];
    }
    return link;
  }

  Future<String> validateLinkTitle(String link) async{
  bool linkIsShort = link.contains('feature=share') ? true : false;
  bool linkIsShortShare = link.contains('?si=') ? true : false;
  var ytExplode = YoutubeExplode();

  if(linkIsShort){
    var result = link.split('?feature=share');
    var video = await ytExplode.videos.get(result[0]);
    return video.title;
  }
  else if(linkIsShortShare){
    var result = link.split('?si=');
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