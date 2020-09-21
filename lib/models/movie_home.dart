class MovieHome{
  final int id;
  final String title, posterPath, backdropPath, releaseDate, mediaType;
  final List<dynamic> genreIds;
  final double voteAverage;

  MovieHome({this.id, this.title, this.posterPath, this.backdropPath, this.releaseDate, this.genreIds, this.voteAverage, this.mediaType});
}