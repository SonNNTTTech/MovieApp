class ImageResponse {
  List<ImageDetail>? backdrops;
  int? id;
  List<ImageDetail>? logos;
  List<ImageDetail>? posters;

  ImageResponse({this.backdrops, this.id, this.logos, this.posters});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <ImageDetail>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(ImageDetail.fromJson(v));
      });
    }
    id = json['id'];
    if (json['logos'] != null) {
      logos = <ImageDetail>[];
      json['logos'].forEach((v) {
        logos!.add(ImageDetail.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <ImageDetail>[];
      json['posters'].forEach((v) {
        posters!.add(ImageDetail.fromJson(v));
      });
    }
  }
}

class ImageDetail {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  ImageDetail(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  ImageDetail.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}
