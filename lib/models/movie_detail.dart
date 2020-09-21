class MovieDetail{
  final String posterPath, title, overview, releaseDate;
  final List<dynamic> genres;
  final int runtime;
  final double voteAverage;
  MovieDetail({this.title, this.posterPath, this.overview, this.releaseDate, this.genres, this.runtime, this.voteAverage});
}