class MovieDetailEntity {
  final int id;
  final String imageUrl;
  final String title;
  final DateTime? releaseDate;
  final String region;
  final String overview;
  final int rating;
  final List<String> kinds;
  final String duration;
  final String slogan;
  final List<Production> productions;
  final int revenue;
  final List<String> keywords;
  final List<RecommendationMovie> recommendations;
  final List<String> youtubeVideoIds;

  MovieDetailEntity({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.releaseDate,
    required this.region,
    required this.overview,
    required this.rating,
    required this.kinds,
    required this.duration,
    required this.slogan,
    required this.productions,
    required this.revenue,
    required this.keywords,
    required this.recommendations,
    required this.youtubeVideoIds,
  });
}

class Production {
  final String name;
  final String imageUrl;

  Production({required this.name, required this.imageUrl});
}

class RecommendationMovie {
  final String imagerUrl;
  final String name;
  final int id;
  final int rating;

  RecommendationMovie(
      {required this.imagerUrl,
      required this.name,
      required this.id,
      required this.rating});
}
