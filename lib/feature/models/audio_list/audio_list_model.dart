class Audio {
  final String index;
  final String trackname;
  final String trackTitle;
  final String explanation;

  Audio(this.trackname, this.trackTitle, this.explanation, this.index);

  Audio.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        trackname = json['trackname'],
        trackTitle = json['trackTitle'],
        explanation = json['explanation'];

  Map<String, dynamic> toJson() => {'index': index,'trackname': trackname, 'trackTitle': trackTitle, 'explanation': explanation};
}
