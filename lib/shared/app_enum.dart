enum MovieType {
  nowPlaying('Now Playing', 'now_playing'),
  popular('Popular', 'popular'),
  topRated('Top rated', 'top_rated'),
  upcoming('Upcoming', 'upcoming'),
  ;

  final String text;
  final String apiText;
  const MovieType(this.text, this.apiText);
}

enum AuthMode { guest, session }
