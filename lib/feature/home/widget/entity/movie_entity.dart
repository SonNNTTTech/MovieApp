class MovieEntity {
  //rating from 0 -> 100
  final int rate;
  final String name;
  final DateTime date;
  final String imageUrl;
  MovieEntity({
    required this.rate,
    required this.name,
    required this.date,
    required this.imageUrl,
  });
}
