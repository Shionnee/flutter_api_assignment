class DogBreedsModel {
  final List<String> breeds;
  final String status;

  DogBreedsModel({
    required this.breeds,
    required this.status,
  });

  // Factory constructor to create a DogBreeds object from JSON
  factory DogBreedsModel.fromJson(Map<String, dynamic> json) {
    return DogBreedsModel(
      breeds: json['message'].keys.toList(),
      status: json['status'],
    );
  }

  // Convert DogBreeds object to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': breeds,
      'status': status,
    };
  }
}
