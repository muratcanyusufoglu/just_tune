class YoutubeList {
  final String index;
  final String title;
  final String duration;
  final String youtubeLink;

  YoutubeList({required this.title,required this.duration,required this.index, required this.youtubeLink});

  YoutubeList.fromJson(Map<dynamic, dynamic> json)
      : index = json['index'] ?? '',
        title = json['title'] ?? '',
        duration = json['duration'] ?? '',
        youtubeLink = json['youtubeLink'] ?? '';
  
  static List<YoutubeList> fromJsonList(List<dynamic> json) {
    List<YoutubeList> youtubeList = [];
    for (var item in json) {
      youtubeList.add(YoutubeList.fromJson(item));
    } 
    return youtubeList;
    }
  Map<String, dynamic> toJson() => {'index': index,'title': title, 'duration': duration, 'youtubeLink': youtubeLink};
}
