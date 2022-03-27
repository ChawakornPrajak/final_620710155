class Animal {
  final String image;
  final String answer;
  final List<String> choices;

  Animal({
    required this.image,
    required this.answer,
    required this.choices,

  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      image:  json["image_url"],
      answer:  json["answer"],
      choices: List<String>.from(json["choices"]),
    );
  }
}