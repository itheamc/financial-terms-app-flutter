class FinanceTerm {
  final int? id;
  final String? title;
  final String? body;
  final String _author = "@itheamc";

  String? get summary => body != null ? body!.split(".").first : null;

  String get author => _author;

  /// Constructor
  FinanceTerm({
    this.id,
    this.title,
    this.body,
  });

  /// Factory
  factory FinanceTerm.fromJson(Map<String, dynamic> json) {
    return FinanceTerm(
      id: json["_id"],
      title: json["_title"],
      body: json["_body"],
    );
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
