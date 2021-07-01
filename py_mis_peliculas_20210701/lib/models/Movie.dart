class Movie {
  int id;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;

  Movie(
      {this.id,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    return data;
  }

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "title": title,
    };
  }
}