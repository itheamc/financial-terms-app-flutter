class FinanceTerm {
  final int? id;
  final String? title;
  final String? body;
  final String author;

  String? get summary => body != null ? body!.split(".").first : null;

  /// Constructor
  FinanceTerm({this.id, this.title, this.body, this.author = "@mit"});

  /// Factory
  factory FinanceTerm.fromJson(Map<String, dynamic> json) {
    return FinanceTerm(
      id: json["_id"] ?? json["id"],
      title: json["_title"] ?? json["title"],
      body: json["_body"] ?? json["body"],
      author: json['author'] ?? "@mit",
    );
  }

  /// To Map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "author": author,
    };
  }
}

class FinanceTerms {
  final String label;
  final List<FinanceTerm> terms;

  int get count => terms.length;

  FinanceTerms({
    required this.label,
    required this.terms,
  });
}
