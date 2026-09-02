/*CategoryNewsModel start here*/
class CategoryNewsModel {
  final String? status;
  final int? totalResults;
  final List<Articles>? articles;

  const CategoryNewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  /*fromJson start here*/
  factory CategoryNewsModel.fromJson(Map<String, dynamic> json) {
    return CategoryNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'] != null
          ? (json['articles'] as List)
          .map((e) => Articles.fromJson(e))
          .toList()
          : null,
    );
  }
  /*fromJson end here*/

  /*toJson start here*/
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((e) => e.toJson()).toList(),
    };
  }
  /*toJson end here*/

  /*toString start here*/
  @override
  String toString() {
    return 'CategoryNewsModel('
        'status: $status, '
        'totalResults: $totalResults, '
        'articles: ${articles?.length} articles'
        ')';
  }
/*toString end here*/
}
/*CategoryNewsModel end here*/

/*Articles start here*/
class Articles {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /*fromJson start here*/
  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      source: json['source'] != null
          ? Source.fromJson(json['source'])
          : null,
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
  /*fromJson end here*/

  /*toJson start here*/
  Map<String, dynamic> toJson() {
    return {
      'source': source?.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
  /*toJson end here*/

  /*toString start here*/
  @override
  String toString() {
    return 'Articles('
        'source: $source, '
        'author: $author, '
        'title: $title, '
        'publishedAt: $publishedAt'
        ')';
  }
/*toString end here*/
}
/*Articles end here*/

/*Source start here*/
class Source {
  final String? id;
  final String? name;

  const Source({
    this.id,
    this.name,
  });

  /*fromJson start here*/
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
  /*fromJson end here*/

  /*toJson start here*/
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  /*toJson end here*/

  /*toString start here*/
  @override
  String toString() {
    return 'Source(id: $id, name: $name)';
  }
/*toString end here*/
}
/*Source end here*/