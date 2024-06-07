class Prayer {
  final String name;
  final bool status;

  Prayer({required this.name, required this.status});

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      name: json['prayer'],
      status: json['status'],
    );
  }
}
