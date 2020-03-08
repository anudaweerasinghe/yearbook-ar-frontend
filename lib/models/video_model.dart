class Video{

  int id;
  String description;
  String url;
  String thumbnailUrl;
  String qrText;
  int views;

  Video({this.id, this.description, this.url, this.thumbnailUrl, this.qrText,
      this.views});


  factory Video.fromJson(Map<String, dynamic> json){

    return new Video(
      id: json['id'],
      description: json['description'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      qrText: json['qrText'],
      views: json['views'],

    );

  }

}